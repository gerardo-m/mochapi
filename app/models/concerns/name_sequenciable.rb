module NameSequenciable
  extend ActiveSupport::Concern

  class_methods do
    def next_titleized_name(attr)
      base_name = name.titleize
      next_name(attr, base_name, " ")
    end

    def next_camelized_name
      base_name = name.camelize
      next_name(attr, base_name, "")
    end

    def next_underscored_name
      base_name = name.underscore
      next_name(attr, base_name, "_")
    end

    private

    def next_name(attr, base_name, separator)
      actual_name = base_name
      i=0
      while where(attr => actual_name).count > 0
        i +=1
        actual_name = "#{base_name}#{separator}#{i}"
      end
      actual_name
    end
  end
end
