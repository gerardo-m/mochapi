module Admin
  module Api
    class MVariablesController < ApiController
      def set_project_variable
        project = Project.where(id: params[:project_id]).first
        if project.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Project with id #{params[:project]} not found" }, status: :not_found
        end
        is_valid, variable_to_set = validate_variable_to_set(project)
        return variable_to_set unless is_valid
        if variable_to_set.save
          render json: {
            name: variable_to_set.name,
            value: variable_to_set.value,
            url:  "/admin/api/project/#{project.id}/variables/#{variable_to_set.name}"
          }
        else
          render json: { error: 422, error_message: "Failed to save variable",
            message: "#{variable_to_set.errors.full_messages.join(", ")}" }, status: :unprocessable_entity
        end
      end

      def set_endpoint_variable
        endpoint = Endpoint.where(id: params[:endpoint_id]).first
        if endpoint.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Endpoint with id #{params[:endpoint_id]} not found" }, status: :not_found
        end
        is_valid, variable_to_set = validate_variable_to_set(endpoint)
        return variable_to_set unless is_valid
        if variable_to_set.save
          render json: {
            name: variable_to_set.name,
            value: variable_to_set.value,
            url:  "/admin/api/endpoint/#{endpoint.id}/variables/#{variable_to_set.name}"
          }
        else
          render json: { error: 422, error_message: "Failed to save variable",
            message: "#{variable_to_set.errors.full_messages.join(", ")}" }, status: :unprocessable_entity
        end
      end

      def delete_project_variable
        project = Project.where(id: params[:project_id]).first
        if project.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Project with id #{params[:project_id]} not found" }, status: :not_found
        end
        variable_to_delete = project.own_variables.where(name: params[:name]).first
        if variable_to_delete.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Variable with name #{params[:name]} not found" }, status: :not_found
        end
        variable_to_delete.destroy!
      end

      def delete_endpoint_variable
        endpoint = Endpoint.where(id: params[:endpoint_id]).first
        if endpoint.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Endpoint with id #{params[:endpoint_id]} not found" }, status: :not_found
        end
        variable_to_delete = endpoint.own_variables.where(name: params[:name]).first
        if variable_to_delete.nil?
          return render json: { error: 404, error_message: "Not found",
            message: "Variable with name #{params[:name]} not found" }, status: :not_found
        end
        variable_to_delete.destroy!
      end

      protected

      ### returns <bool>, <result>
      ###
      ### It returns true if there are no errors.
      ###
      ### If there is an error, you must return the result, since it already takes
      ### care of the render.
      ###
      ### If there is no error, the value will be the variable to set.
      def validate_variable_to_set(variable_holder)
        req_parameters = request.request_parameters
        if req_parameters[:name].nil?
          return false, render(json: { error: 422, error_message: "Name required",
            message: 'parameter "name" required' }, status: :unprocessable_entity)
        end
        if req_parameters[:value].nil?
          return false, render(json: { error: 422, error_message: "Value required",
            message: 'parameter "value" required' }, status: :unprocessable_entity)
        end
        if req_parameters[:type].present?
          unless MVariable::VALUE_TYPES.include?(req_parameters[:type])
            return false, render(json: { error: 422, error_message: "Invalid type",
              message: """type"" must be #{MVariable::VALUE_TYPES}" }, status: :unprocessable_entity)
          end
        end
        variable_to_set = variable_holder.get_or_create_variable(req_parameters[:name])
        variable_to_set.value_type = req_parameters[:type]
        variable_to_set.assign_value(req_parameters[:value])
        return true, variable_to_set
      end
    end
  end
end
