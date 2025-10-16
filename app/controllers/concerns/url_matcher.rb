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
        match = template.match(encode_url(apiurl))
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

    private

    def encode_url(url)
      # This is needed becaues the encoding with CharacterClasses::PATH
      # does not escape exclamation marks, and the matcher doesn't match
      # if the url contains exclamation marks.
      encoder = Addressable::URI::CharacterClasses::UNRESERVED + "\\:\\@\\/"
      encoded_url = Addressable::URI.encode_component(url, encoder)
      encoded_url
    end
  end
end
