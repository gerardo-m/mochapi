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
    m_name = "#{operation.downcase}_met?"
    # We probably need to log this or put a warning in this case
    return false unless respond_to? m_name, true
    send(m_name, mochapi_request)
  end

  def parent_conditionable
    if conditionable.is_a?(Expression)
      return conditionable.parent_conditionable
    end
    conditionable
  end

  private

  def is_numeric?(value)
    Float(value) != nil rescue false
  end

  def is_present_met?(mochapi_request)
    if operand1_type == "param"
      return mochapi_request.path_parameters.keys.include?(operand1_val)
    end
    if operand1_type == "header"
      return mochapi_request.headers.include?(operand1_val)
    end
    if operand1_type == "variable"
      return parent_conditionable.endpoint.variables.select { |v| v.name.strip == operand1_val.strip }.first.present?
    end
    false
  end

  def is_not_present_met?(mochapi_request)
    !is_present_met?(mochapi_request)
  end

  def is_a_number_met?(mochapi_request)
    value_to_verify = nil
    value_to_verify = mochapi_request.path_parameters[operand1_val] if operand1_type == "param"
    value_to_verify = mochapi_request.headers[operand1_val] if operand1_type == "header"
    value_to_verify = parent_conditionable.endpoint.variables.select { |v| v.name.strip == operand1_val.strip }.first.value if operand1_type == "variable"
    is_numeric?(value_to_verify)
  end

  def is_not_a_number_met?(mochapi_request)
    !is_a_number_met?(mochapi_request)
  end
end
