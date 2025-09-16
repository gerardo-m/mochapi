class AddBooleanValueToMVariables < ActiveRecord::Migration[8.0]
  def change
    add_column :m_variables, :boolean_value, :boolean
  end
end
