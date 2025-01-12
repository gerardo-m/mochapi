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
      endpoint, path_params = match_endpoint(project, "GET", params[:apiurl])
      if endpoint.nil?
        return render json: { error: 404, error_message: "Not found",
          message: "Endpoint GET #{params[:apiurl]} not found" }, status: :not_found
      end
      handle_endpoint(endpoint, path_params)
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
        return endpoint, path_params if matches
      end
      return nil, nil
    end

    def handle_endpoint(endpoint, path_params)
      render endpoint.response.solve(path_params)
    end
  end
end
