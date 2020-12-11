class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :deadline, :datetime
    add_column :posts, :note, :text
    add_index :posts, :deadline
  end
end
