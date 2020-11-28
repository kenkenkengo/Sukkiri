class Group < ApplicationRecord
  has_many :belongings
  has_many :users, through: :belongings, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def admin_user
    User.find_by(id: admin_user_id)
  end
end
