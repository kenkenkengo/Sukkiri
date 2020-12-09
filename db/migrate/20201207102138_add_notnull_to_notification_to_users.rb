class AddNotnullToNotificationToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :notification, :boolean, null: false
  end
end
