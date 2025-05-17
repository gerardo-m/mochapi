class AddDefaultToResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :expressions do |t|
      t.text :operand1_val
      t.string :operand1_type
      t.string :operation
      t.text :operand2_val
      t.string :operand2_type

      t.bigint :conditionable_id
      t.string :conditionable_type

      t.timestamps
    end

    add_index :expressions, [ :conditionable_type, :conditionable_id ]

    add_column :responses, :order_number, :int, default: 0
  end
end
