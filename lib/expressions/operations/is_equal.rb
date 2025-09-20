module Expressions
  module Operations
    class IsEqual < Expressions::Operation
      main_name "IS_EQUAL"
      negation_name "IS_NOT_EQUAL"
      operands_count 2
      operand_return_types :string, :number, :boolean
      operand_form_types :value, :name

      # def is_met?(expression, mochapi_request)
      # end

      def is_met?(expression, mochapi_request)
        equal = is_equal(expression.operand1_type, expression.operand1_val,
          expression.operand2_type, expression.operand2_val, expression.parent_conditionable.endpoint,
          mochapi_request)
        if is_negation?
          return !equal
        end
        equal
      end

      private

      def is_equal(operand1_type, operand1_val, operand2_type, operand2_val, endpoint, mochapi_request)
        value1 = get_value(operand1_type, operand1_val, endpoint, mochapi_request)
        value2 = get_value(operand2_type, operand2_val, endpoint, mochapi_request)
        compare(value1, value2)
      end

      def get_value(operand_type, operand_val, endpoint, mochapi_request)
        value = nil
        if operand_type == "param"
          value = mochapi_request.path_parameters[operand_val]
          value = value.to_f if is_numeric?(value)
        end
        if operand_type == "header"
          value = mochapi_request.headers[operand_val]
          value = value.to_f if is_numeric?(value)
        end
        if operand_type == "variable"
          value = endpoint.variables.select { |v| v.name.strip == operand_val.strip }.first.value
        end
        if operand_type == "string"
          value = operand_val
        end
        if operand_type == "number"
          value = operand_val.to_f
        end
        if operand_type == "boolean"
          value = operand_val.to_bool
        end
        value
      end

      def compare(value1, value2)
        value1 = value1.to_f if value1.is_a?(Numeric)
        value2 = value2.to_f if value2.is_a?(Numeric)
        if value1.is_a?(String) && value2.is_a?(String)
          return value1 == value2
        end
        if value1.is_a?(Numeric) && value2.is_a?(Numeric)
          return value1 == value2
        end
        if (value1.is_a?(TrueClass) && value2.is_a?(TrueClass)) || (value1.is_a?(FalseClass) && value2.is_a?(FalseClass))
          return value1 == value2
        end
        if value1.is_a?(NilClass) && value2.is_a?(NilClass)
          return true
        end
        if value1.is_a?(String)
          return value1 == value2.to_s
        end
        if value2.is_a?(String)
          return value1.to_s == value2
        end
        value1 == value2
      end

      def is_numeric?(value)
        Float(value) != nil rescue false
      end
    end
  end
end
