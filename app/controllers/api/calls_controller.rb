module Api
  class CallsController < ApiController
    def initialize
    end

    def get
      project = Project.where(space_name: params[:project]).first
      if project.nil?
        return render json: { error: 404, error_message: "Not found",
          message: "Project with space name #{params[:project]} not found" }
      end
      endpoint = Endpoint.where(method: "GET", url: params[:apiurl]).first
      if endpoint.nil?
        return render json: { error: 404, error_message: "Not found",
          message: "Endpoint GET #{params[:apiurl]} not found" }
      end
      handle_endpoint(endpoint)
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
    def handle_endpoint(endpoint)
      render json: { message:
        "Received call to #{endpoint.project.space_name} with the following path: #{endpoint.method} /#{endpoint.url}" }
    end
  end
end
