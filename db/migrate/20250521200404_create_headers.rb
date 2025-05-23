class CreateHeaders < ActiveRecord::Migration[8.0]
  def change
    create_table :headers do |t|
      t.references :response, null: false, foreign_key: true
      t.string :field
      t.string :value
      t.boolean :enabled

      t.timestamps
    end
  end
end
