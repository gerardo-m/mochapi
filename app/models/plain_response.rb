class PlainResponse < ApplicationRecord
  include Responseable

  def solve(params)
    variables = PlainResponseParser.get_variables(content)
    endpoint_vars = params
    n_content = ""
    variables.each do |var|
      evi = endpoint_vars.index { |v| v.name == var }
      unless evi.nil?
        n_content = PlainResponseParser.replace_variable(content, var, endpoint_vars[evi].value)
        next
      end
    end
    { plain: n_content }
  end
end
