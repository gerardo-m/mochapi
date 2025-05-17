module PlainResponseParser
  def self.get_variables(content)
    icontent = content.to_s
    regexp = /[$]{[a-zA-Z][a-zA-Z0-9._-]*}/
    vars = []
    var = icontent[regexp]
    while !var.nil?
      vars << var[/[a-zA-Z][a-zA-Z0-9._-]*/]
      offset = icontent =~ regexp
      icontent = icontent[offset + var.length, (icontent.length() -1)]
      var = icontent[regexp]
    end
    vars
  end

  def self.replace_variable(content, var, value)
    to_replace = [
      "${#{var}}"
    ]
    icontent = content.to_s
    to_replace.each do |placeholder|
      icontent = icontent.gsub(placeholder, value)
    end
    icontent
  end
end
