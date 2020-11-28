class ChangeDataAdminUserIdToGroups < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :admin_user_id, :bigint
  end
end
