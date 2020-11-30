class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validate :image_size
  default_scope -> { order(created_at: :desc) }

  validates :image, presence: true
  mount_uploader :image, ImageUploader

  private

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "：5MBより大きい画像はアップロードできません。")
    end
  end
end
