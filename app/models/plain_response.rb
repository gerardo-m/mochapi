class PlainResponse < ApplicationRecord
  include Responseable

  def solve(path_params)
    variables = PlainResponseParser.get_variables(content)
    endpoint_vars = path_params
    n_content = content
    variables.each do |var|
      if endpoint_vars.keys.include?(var)
        n_content = PlainResponseParser.replace_variable(content, var, endpoint_vars[var])
        next
      end
    end
    { plain: n_content }
  end
end
