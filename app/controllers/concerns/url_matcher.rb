module UrlMatcher
  extend ActiveSupport::Concern

  included do
    protected

    ### Returns an Endpoint object and a MochapiRequest if the
    ### provided method and url match an existing endpoint in the
    ### project.
    ###
    ### Returns nil, nil otherwise
    def match_endpoint(project, method, apiurl)
      project.endpoints.each do |endpoint|
        next unless endpoint.method == method
        path = endpoint.complete_path
        return if path.blank?
        template = Addressable::Template.new(endpoint.complete_path)
        match = template.match(apiurl)
        if match.present?
          mochapi_request = build_mochapi_request(match)
          return endpoint, mochapi_request
        end
      end
      return nil, nil
    end

    def build_mochapi_request(path_params)
      mochapi_request = MochapiRequest.new
      mochapi_request.headers = request.headers
      mochapi_request.path_parameters = path_params
      mochapi_request.query_parameters = request.query_parameters
      mochapi_request.request_parameters = request.request_parameters
      mochapi_request
    end
  end
end
