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
  end

  def destroy
  end

  protected 

  def set_m_variable
    puts "CALLED"
    @m_variable = MVariable.find(params.expect(:id))
  end

end
