class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :likes, dependent: :destroy
  validate :image_size
  validates :image, presence: true
  mount_uploader :image, ImageUploader

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: self.id)
  end

  private

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "：5MBより大きい画像はアップロードできません。")
    end
  end
end
