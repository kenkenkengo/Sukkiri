class DeleteAdminUserIdUniqIndexFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_index :groups, :admin_user_id
    add_index :groups, :admin_user_id
  end
end
