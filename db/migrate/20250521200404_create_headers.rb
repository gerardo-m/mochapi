class CreateHeaders < ActiveRecord::Migration[8.0]
  def change
    create_table :headers do |t|
      t.references :endpoint, null: false, foreign_key: true
      t.string :field
      t.string :value

      t.timestamps
    end
  end
end
