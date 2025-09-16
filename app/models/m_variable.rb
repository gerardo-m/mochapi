class MVariable < ApplicationRecord
  include NameSequenciable

  attr_accessor :value
  belongs_to :variable_holder, polymorphic: true

  before_validation :assign_defaults

  validates :name, presence: true, uniqueness: { scope: [ :variable_holder_type, :variable_holder_id ] }

  VALUE_TYPES = [ "Text", "Integer", "Decimal", "Boolean" ]

  def self.create_default(variable_holder_type, variable_holder_id)
    new_m_variable = MVariable.new
    new_m_variable.name = next_camelized_name(:name, variable_holder_type: variable_holder_type, variable_holder_id: variable_holder_id)
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

  def assign_value(new_value)
    if self.value_type == "Integer"
      self.integer_value = new_value
    elsif self.value_type == "Text"
      self.text_value = new_value
    elsif self.value_type == "Decimal"
      self.decimal_value = new_value
    end
  end

  protected

  def assign_defaults
    self.value_type ||= VALUE_TYPES.first
  end
end
