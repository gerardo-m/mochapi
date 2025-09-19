class ExpressionsController < ApplicationController
  before_action :set_expression, only: %i[  edit update  ]

  def edit
  end

  def update
    @expression.update(expression_params)
  end

  private

  def set_expression
    @expression = Expression.find(params.expect(:id))
  end

  def expression_params
    params.expect(expression: [ :operation, :operand1_type, :operand1_val, :operand2_type, :operand2_val, :operand1_form, :operand2_form ])
  end
end
