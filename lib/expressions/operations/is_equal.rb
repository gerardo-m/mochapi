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
    end
  end
end
