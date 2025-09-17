module Expressions
  module Operations
    class IsPresent < Expressions::Operation

      main_name "IS_PRESENT"
      negation_name "IS_NOT_PRESENT"
      operands_count 1
      operand_return_types :string
      operand_form_types :name

      def is_met?(expression, mochapi_request)
        present = is_present(expression.operand1_type, expression.operand1_val, 
          expression.parent_conditionable.endpoint, mochapi_request)
        if is_negation?
          return !present
        end
        present
      end

      private
      
      def is_present(operand_type, operand_val, endpoint, mochapi_request)
        if operand_type == "param"
          return mochapi_request.path_parameters.keys.include?(operand_val)
        end
        if operand_type == "header"
          return mochapi_request.headers.include?(operand_val)
        end
        if operand_type == "variable"
          return endpoint.variables.select { |v| v.name.strip == operand_val.strip }.first.present?
        end
        false
      end
    end
  end
end