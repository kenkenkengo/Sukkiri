class Notification < ApplicationRecord
  belongs_to :user

  enum action_type: { liked_to_post: 0, commented_to_post: 1 }

  validates :post_id, presence: true
  validates :action_type, presence: true
  validates :from_user_id, presence: true

  def active_user
    User.find_by(id: from_user_id)
  end

  def activated_post
    Post.find_by(id: post_id)
  end

  def activated_group
    Post.find_by(id: post_id).group
  end
end
