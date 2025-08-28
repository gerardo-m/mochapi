module Admin
  module Api
    class MVariablesController < ApiController
      def set_project_variable
        project = Project.where(id: params[:project_id]).first
        if project.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Project with id #{params[:project]} not found" }, status: :not_found
        end
        req_parameters = request.request_parameters
        if req_parameters[:name].nil?
          return render json: { error: 422, error_message: "Name required",
            message: 'parameter "name" required' }, status: :unprocessable_entity
        end
        if req_parameters[:value].nil?
          return render json: { error: 422, error_message: "Value required",
            message: 'parameter "value" required' }, status: :unprocessable_entity
        end
        variable_to_set = project.get_or_create_variable(req_parameters[:name])
        render plain: "working #{variable_to_set.id}, #{variable_to_set.name}"
      end

      def set_endpoint_variable
      end
    end
  end
end
