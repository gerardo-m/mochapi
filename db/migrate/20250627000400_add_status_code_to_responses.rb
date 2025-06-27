class AddStatusCodeToResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :responses, :status_code, :integer
  end
end
