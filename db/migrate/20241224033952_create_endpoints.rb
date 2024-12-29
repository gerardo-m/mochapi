class CreateEndpoints < ActiveRecord::Migration[8.0]
  def change
    create_table :endpoints do |t|
      t.string :name
      t.string :path
      t.string :method
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
