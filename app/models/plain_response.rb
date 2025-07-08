class PlainResponse < ApplicationRecord
  include Responseable

  def solve(mochapi_request)
    variables = PlainResponseParser.get_variables(content)
    n_content = content
    variables.each do |var|
      if mochapi_request.path_parameters.keys.include?(var)
        n_content = PlainResponseParser.replace_variable(content, var, mochapi_request.path_parameters[var])
        next
      end
      if mochapi_request.headers.include?(var)
        n_content = PlainResponseParser.replace_variable(content, var, mochapi_request.headers[var])
        next
      end
    end
    { plain: n_content, status: self.response.status_code }
  end
end
