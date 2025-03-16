class CreateRememberedValues < ActiveRecord::Migration[8.0]
  def change
    create_table :remembered_values do |t|
      t.string :control_attribute
      t.string :value_attribute

      t.string :control_attribute_type
      t.string :value_attribute_type

      t.string :control_attribute_value
      t.string :value_attribute_value

      t.string :value_interchangeable_type
      t.bigint :value_interchangeable_id

      t.timestamps
    end

    add_index :remembered_values, [ :value_interchangeable_type, :value_interchangeable_id ]
  end
end
