module Admin
  module Api
    class InfoController < ApiController
      include UrlMatcher

      def get_info
        project = Project.where(space_name: params[:project]).first
        if project.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Project with space name #{params[:project]} not found" }, status: :not_found
        end
        method = params[:method]
        method = method.upcase if method.present?
        method = Constants::SUPPORTED_METHODS.first if method.blank?
        endpoint, mochapi_request = match_endpoint(project, method, params[:apiurl])
        if endpoint.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Endpoint #{method} #{params[:apiurl]} not found" }, status: :not_found
        end
        info = {
          url: params[:apiurl],
          project_id: project.id,
          endpoint_id: endpoint.id,
          project_variables_url: "/admin/api/project/#{project.id}/variables",
          endpoint_variables_url: "/admin/api/endpoint/#{endpoint.id}/variables"
        }
        render json: info
      end
    end
  end
end
