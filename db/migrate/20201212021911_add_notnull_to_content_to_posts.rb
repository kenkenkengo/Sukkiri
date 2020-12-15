class AddNotnullToContentToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :content, :string, null: false
  end
end
