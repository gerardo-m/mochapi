module EndpointPaths
  class ParsedPath
    attr_reader :raw_path, :fragments, :params

    def initialize(string_path, is_registered_path = false)
      @raw_path = ActionDispatch::Journey::Router::Utils.normalize_path(string_path)
      @fragments = Parser.to_fragments(@raw_path, is_registered_path)
      @params = @fragments.select { |fragment| fragment.is_variable? }
    end
  end

  class RegisteredPath < ParsedPath
    def initialize(string_path)
      super(string_path, true)
    end

    def matches?(parsed_path)
      return false unless @fragments.length == parsed_path.fragments.length
      n_params = []
      (0..@fragments.length-1).each do |i|
        fragment = @fragments[i]
        matcher_f = parsed_path.fragments[i]
        return false if matcher_f.nil?
        if fragment.is_variable?
          n_fragment = PathFragment.new
          n_fragment.name = fragment.name
          n_fragment.value = matcher_f.value
          n_params << n_fragment
          next
        end
        return false unless fragment.value == matcher_f.value
      end
      return true, n_params
    end
  end

  class PathFragment
    attr_accessor :name, :value

    def is_variable?
      !@name.nil?
    end
  end

  class Parser
    def self.to_fragments(normalized_path, is_registered_path)
      fragments = []
      f = normalized_path.split("/")
      f.each do |ff|
        next if ff.blank?
        fragments << build_fragment(ff, is_registered_path)
      end
      fragments
    end

    private

    def self.build_fragment(str, is_registered_path = false)
      pf = PathFragment.new
      pf.value = str
      if is_registered_path and str.start_with?(/:[a-zA-Z]/)
        pf.name = str[1, (str.length() -1)]
        pf.value = nil
      end
      pf
    end
  end
end
