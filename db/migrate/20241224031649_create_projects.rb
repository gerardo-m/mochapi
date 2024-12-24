class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :space_name
      t.string :url_preffix

      t.timestamps
    end
  end
end
