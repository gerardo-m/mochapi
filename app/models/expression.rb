class Expression < ApplicationRecord
  include ValueInterchangeable

  # Should have 0 to 2 that are the operands.
  #
  # The operands may be variables or constants so they will not always
  # be another expression.
  has_many :expressions, as: :conditionable

  belongs_to :conditionable, polymorphic: true

  remember_value :operand1_form, :operand1_type
  remember_value :operand1_form, :operand1_val
  remember_value :operand2_form, :operand2_type
  remember_value :operand2_form, :operand2_val

  before_update :check_operands_changed

  def is_met?(mochapi_request)
    return true if operation.blank?
    # This will raise an error if the operation is invalid
    # We probably need to log this or put a warning in that case
    verifier = Expressions::Operation.create_new(operation.upcase)
    verifier.is_met?(self, mochapi_request)
  end

  def available_operand_forms
    @operation_handler ||= Expressions::Operation.create_new(operation.upcase)
    @operation_handler.operand_form_types
  end

  def available_operand_types
    @operation_handler ||= Expressions::Operation.create_new(operation.upcase)
    @operation_handler.operand_return_types
  end

  def has_operand2?
    @operation_handler ||= Expressions::Operation.create_new(operation.upcase)
    @operation_handler.operands_count > 1
  end

  def operand1_form
    super || available_operand_forms.first
  end

  def operand2_form
    super || available_operand_forms.first
  end

  def should_render_operands?
    @render_operands
  end

  def parent_conditionable
    if conditionable.is_a?(Expression)
      return conditionable.parent_conditionable
    end
    conditionable
  end

  def duplicate
    new_expression = self.dup
    self.expressions.each do |expression|
      new_expression.expressions << expression.duplicate
    end
    # We still need to duplicate the operands if
    # they are expressions
    new_expression
  end

  private

  def check_operands_changed
    return @render_operands = true if operand1_type_changed? || operand2_type_changed? || operation_changed?
    if operand1_val_changed?
      return @render_operands = true if operand1_type == "boolean"
    end
    if operand2_val_changed?
      return @render_operands = true if operand2_type == "boolean"
    end
    @render_operands = false
  end
end
