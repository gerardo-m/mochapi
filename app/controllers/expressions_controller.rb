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
    params.expect(expression: [ :operation ])
  end
end
