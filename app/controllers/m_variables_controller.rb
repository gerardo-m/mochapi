class MVariablesController < ApplicationController
  # before_action :set_project, only: %i[ show edit update destroy ]
  before_action :set_m_variable, only: %i[ edit update destroy]

  def new
    @m_variable = MVariable.create_default(params.expect(:variable_holder_type), params.expect(:variable_holder_id))
    @m_variable.save!
  end

  def edit
  end

  def update
    @m_variable.update(m_variables_params)
  end

  def destroy
    @m_variable.destroy!
  end

  protected

  def set_m_variable
    @m_variable = MVariable.find(params.expect(:id))
  end

  def m_variables_params
    params.expect(m_variable: [ :id, :name, :value_type, :integer_value, :decimal_value, :text_value ])
  end
end
