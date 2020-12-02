class Group < ApplicationRecord
  has_many :belongings
  has_many :users, through: :belongings, dependent: :destroy
  has_many :posts
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :admin_user_id, presence: true

  def admin_user
    User.find_by(id: admin_user_id)
  end
end
