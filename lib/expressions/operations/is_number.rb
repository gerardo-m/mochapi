module Expressions
  module Operations
    class IsNumber < Expressions::Operation
      main_name "IS_A_NUMBER"
      negation_name "IS_NOT_A_NUMBER"
      operands_count 1
      operand_return_types :string
      operand_form_types :name

      def is_met?(expression, mochapi_request)
        number = is_number(expression.operand1_type, expression.operand1_val, 
          expression.parent_conditionable.endpoint, mochapi_request)
        if is_negation?
          return !number
        end
        number
      end

      private

      def is_number(operand_type, operand_val, endpoint, mochapi_request)
        value_to_verify = nil
        value_to_verify = mochapi_request.path_parameters[operand_val] if operand_type == "param"
        value_to_verify = mochapi_request.headers[operand_val] if operand_type == "header"
        value_to_verify = endpoint.variables.select { |v| v.name.strip == operand_val.strip }.first.value if operand_type == "variable"
        is_numeric?(value_to_verify)
      end

      def is_numeric?(value)
        Float(value) != nil rescue false
      end
    end
  end
end