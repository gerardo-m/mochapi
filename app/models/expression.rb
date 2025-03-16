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

  private

  def perform_operation_change
    puts "#### CHANGING OPERATION"
  end
end
