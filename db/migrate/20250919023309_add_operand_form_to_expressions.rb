class AddOperandFormToExpressions < ActiveRecord::Migration[8.0]
  def change
    add_column :expressions, :operand1_form, :string
    add_column :expressions, :operand2_form, :string
  end
end
