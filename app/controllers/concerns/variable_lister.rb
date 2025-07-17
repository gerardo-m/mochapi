module VariableLister
  extend ActiveSupport::Concern

  def variables
    model_constant = controller_name.classify.constantize
    @model_instance = model_constant.find(params[:id])
    @inherited_variables = @model_instance.inherited_variables
    @own_variables = @model_instance.own_variables
    render "m_variables/index"
  end
end
