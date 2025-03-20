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

  def is_met?(path_params)
    m_name = "#{operation.downcase}_met?"
    # We probably need to log this or put a warning in this case
    return false unless respond_to? m_name, true
    send(m_name, path_params)
  end

  private

  def is_numeric?(value)
    Float(value) != nil rescue false
  end

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

  def is_a_met?(path_params)
    if operand1_type == "param"
      value_to_verify = path_params[operand1_val]
      puts "###", value_to_verify, operand2_type
      return is_numeric?(value_to_verify) if operand2_type == "number"
      return !value_to_verify.nil? if operand2_type == "text"
    end
    false
    # TODO Finish for headers
  end

  def is_not_a_met?(path_params)
    !is_not_a_met?(path_params)
  end
end
