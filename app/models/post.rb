class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validate :image_size
  validates :content, presence: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  scope :sort_desc, -> { order(id: "DESC") }

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end

  private

  def image_size
    if image.size > 5.megabytes
      flash.now[:alert] = '5MBより大きい画像はアップロードできません'
    end
  end
end
