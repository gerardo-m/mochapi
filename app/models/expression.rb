class Expression < ApplicationRecord
  include ValueInterchangeable

  # Should have 0 to 2 that are the operands.
  #
  # The operands may be variables or constants so they will not always
  # be another expression.
  has_many :expressions, as: :conditionable

  belongs_to :conditionable, polymorphic: true

  remember_value :form_type, :operand1_type
  remember_value :form_type, :operand1_val
  remember_value :form_type, :operand2_type
  remember_value :form_type, :operand2_val

  def form_type
    Constants::EXPRESSION_OPERANDS[operation]
  end

  def form_type_was
    Constants::EXPRESSION_OPERANDS[operation_was]
  end

  def form_type_changed?
    form_type != form_type_was
  end

  def is_met?(mochapi_request)
    # This will raise an error if the operation is invalid
    # We probably need to log this or put a warning in that case
    verifier = Expressions::Operation.create_new(operation.upcase)
    verifier.is_met?(self, mochapi_request)
  end

  def available_operand_forms
    @operation_handler ||= Expressions::Operation.create_new(operation.upcase)
    @operation_handler.operand_form_types
  end

  def operand1_form
    super || available_operand_forms.first
  end

  def parent_conditionable
    if conditionable.is_a?(Expression)
      return conditionable.parent_conditionable
    end
    conditionable
  end

  private
end
