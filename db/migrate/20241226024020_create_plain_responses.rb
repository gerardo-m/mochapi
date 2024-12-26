class CreatePlainResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :plain_responses do |t|
      t.string :content

      t.timestamps
    end
  end
end
