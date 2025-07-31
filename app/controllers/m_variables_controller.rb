class MVariablesController < ApplicationController
  # before_action :set_project, only: %i[ show edit update destroy ]
  before_action :set_m_variable, only: %i[ edit update destroy]

  def new
    @m_variable = MVariable.create_default(params.expect(:variable_holder_type), params.expect(:variable_holder_id))
    @m_variable.save!
  end

  def edit
    set_variable_holder
    @new_m_variable = @m_variable.create_copy_for(@variable_holder)
    @new_m_variable.save!
  end

  def update
    @m_variable.update(m_variables_params)
  end

  def destroy
    variable_holder = @m_variable.variable_holder
    @m_variable.destroy!
    @inherited_variable = variable_holder.inherited_variables.select { |v| v.name.strip == @m_variable.name.strip }.first
    @model_instance = @inherited_variable.variable_holder
  end

  protected

  def set_m_variable
    @m_variable = MVariable.find(params.expect(:id))
  end

  def set_variable_holder
    model_type = params.expect(:variable_holder_type)
    model_constant = model_type.classify.constantize
    @variable_holder = model_constant.find(params.expect(:variable_holder_id))
  end

  def m_variables_params
    params.expect(m_variable: [ :id, :name, :value_type, :integer_value, :decimal_value, :text_value ])
  end
end
