module VariableLister
  extend ActiveSupport::Concern

  def variables
    render "variables/index"
  end
end
