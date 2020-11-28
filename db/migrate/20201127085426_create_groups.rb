class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.integer :admin_user_id, null: false
      t.string :name, null: false
      t.index :admin_user_id, unique: true
      t.index :name, unique: true
      t.timestamps
    end
  end
end
