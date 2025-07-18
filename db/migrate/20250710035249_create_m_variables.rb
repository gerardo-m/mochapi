class CreateMVariables < ActiveRecord::Migration[8.0]
  def change
    create_table :m_variables do |t|
      t.string :name
      t.string :value_type
      t.integer :integer_value
      t.decimal :decimal_value
      t.text :text_value
      t.belongs_to :variable_holder, polymorphic: true

      t.timestamps
    end
  end
end
