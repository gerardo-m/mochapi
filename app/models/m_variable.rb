class MVariable < ApplicationRecord
  include NameSequenciable

  attr_accessor :value
  belongs_to :variable_holder, polymorphic: true

  VALUE_TYPES = [ "Integer", "Text", "Decimal" ]

  def self.create_default(variable_holder_type, variable_holder_id)
    new_m_variable = MVariable.new
    new_m_variable.name = next_titleized_name(:name, variable_holder_type: variable_holder_type, variable_holder_id: variable_holder_id)
    new_m_variable.value_type = "Text"
    new_m_variable.text_value = "Value"
    new_m_variable.variable_holder_type = variable_holder_type
    new_m_variable.variable_holder_id = variable_holder_id
    new_m_variable
  end

  def create_copy_for(variable_holder)
    new_m_variable = self.dup
    new_m_variable.variable_holder_id = variable_holder.id
    new_m_variable.variable_holder_type = variable_holder.class.name
    new_m_variable
  end

  def value
    if self.value_type == "Integer"
      return self.integer_value
    elsif self.value_type == "Text"
      return self.text_value
    elsif self.value_type == "Decimal"
      return self.decimal_value
    end
    self.integer_value
  end

  protected
end
