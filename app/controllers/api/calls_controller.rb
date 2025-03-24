module Api
  class CallsController < ApiController
    def initialize
    end

    def get
      project = Project.where(space_name: params[:project]).first
      if project.nil?
        return render json: { error: 404, error_message: "Not found",
          message: "Project with space name #{params[:project]} not found" }, status: :not_found
      end
      endpoint, mochapi_request = match_endpoint(project, "GET", params[:apiurl])
      if endpoint.nil?
        return render json: { error: 404, error_message: "Not found",
          message: "Endpoint GET #{params[:apiurl]} not found" }, status: :not_found
      end
      handle_endpoint(endpoint, mochapi_request)
    end

    def post
      render json: { message: "TODO" }
    end

    def put
      render json: { message: "TODO" }
    end

    def patch
      render json: { message: "TODO" }
    end

    protected

    def match_endpoint(project, method, apiurl)
      parsed_path = EndpointPaths::ParsedPath.new(apiurl)
      project.endpoints.each do |endpoint|
        matches, path_params = endpoint.parsed_path.matches?(parsed_path)
        if matches
          mochapi_request = build_mochapi_request(path_params)
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

    def handle_endpoint(endpoint, mochapi_request)
      chosen_response = choose_response(endpoint, mochapi_request)
      render chosen_response.solve(mochapi_request)
    end

    def choose_response(endpoint, mochapi_request)
      responses = endpoint.responses.order(order_number: :desc)
      responses.each do |response|
        return response if response.order_number == 0
        return response if response.conditions_met?(mochapi_request)
      end
      endpoint.default_response
    end
  end
end
