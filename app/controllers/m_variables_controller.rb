class MVariablesController < ApplicationController
  # before_action :set_project, only: %i[ show edit update destroy ]

  def new
    @m_variable = MVariable.new
    @m_variable.name = "Prueba"
  end

  def edit
  end
end
