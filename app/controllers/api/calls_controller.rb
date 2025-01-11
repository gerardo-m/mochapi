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
      endpoint, n_params = match_endpoint(project, "GET", params[:apiurl])
      if endpoint.nil?
        return render json: { error: 404, error_message: "Not found",
          message: "Endpoint GET #{params[:apiurl]} not found" }, status: :not_found
      end
      handle_endpoint(endpoint, n_params)
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
        matches, n_params = endpoint.parsed_path.matches?(parsed_path)
        return endpoint, n_params if matches
      end
      return nil, nil
    end

    def handle_endpoint(endpoint, n_params)
      render endpoint.response.solve(n_params)
      # render json: { message:
      #   "Received call to #{endpoint.project.space_name} with the following path: #{endpoint.method} /#{endpoint.url}" }
    end
  end
end
