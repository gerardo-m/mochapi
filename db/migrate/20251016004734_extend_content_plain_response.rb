class ExtendContentPlainResponse < ActiveRecord::Migration[8.0]
  def change
    change_column :plain_responses, :content, :text
  end
end
