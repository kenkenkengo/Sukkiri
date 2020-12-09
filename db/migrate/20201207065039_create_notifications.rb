class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true, null: false
      t.bigint :post_id, null: false
      t.bigint :action_type, null: false
      t.text :comment
      t.bigint :from_user_id, null: false
      t.timestamps
    end
  end
end
