class CreateMVariables < ActiveRecord::Migration[8.0]
  def change
    create_table :m_variables do |t|
      t.string :value_type
      t.integer :int_value
      t.decimal :decimal_value
      t.text :text_value
      t.string :variable_holder_type
      t.integer :variable_holder_id

      t.timestamps
    end

    add_index :m_variables, [ :variable_holder_type, :variable_holder_id ]
  end
end
