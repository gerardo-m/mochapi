class Expression < ApplicationRecord
  include ValueInterchangeable

  # Should have 0 to 2 that are the operands.
  #
  # The operands may be variables or constants so they will not always
  # be another expression.
  has_many :expressions, as: :conditionable

  belongs_to :conditionable, polymorphic: true

  # before_update :perform_operation_change, :if => :operation_changed?

  remember_value :operation, :operand1_type
  remember_value :operation, :operand1_val

  def form_type
    Constants::EXPRESSION_OPERANDS[operation]
  end

  def is_met?(path_params)
    return is_present_met?(path_params) if operation == "IS_PRESENT"
    return is_not_present_met?(path_params) if operation == "IS_NOT_PRESENT"
    false
    # TODO Finish this
  end

  private

  def is_present_met?(path_params)
    if operand1_type == "param"
      return path_params.keys.include?(operand1_val)
    end
    false
    # TODO Finish for headers
  end

  def is_not_present_met?(path_params)
    !is_present_met?(path_params)
  end
end
