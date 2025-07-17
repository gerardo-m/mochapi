class MVariable < ApplicationRecord
  include NameSequenciable

  attr_accessor :value
  belongs_to :variable_holder, polymorphic: true
  before_save :assign_value

  VALUE_TYPES = ["Integer", "Text", "Decimal"]

  def self.create_default(variable_holder_type, variable_holder_id)
    new_m_variable = MVariable.new
    new_m_variable.name = next_titleized_name(:name)
    new_m_variable.value_type = "Text"
    new_m_variable.text_value = "Value"
    new_m_variable.variable_holder_type = variable_holder_type
    new_m_variable.variable_holder_id = variable_holder_id
    new_m_variable
  end

  protected

  def assign_value
    if self.value_type == "Integer"
      self.int_value = self.value
    elsif self.value_type == "Text"
      self.text_value = self.value
    elsif self.value_type == "Decimal"
      self.decimal_value = self.value
    end
  end
  
end
