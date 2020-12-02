class AddNotNullImageToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :image, :string, null: false
  end
end
