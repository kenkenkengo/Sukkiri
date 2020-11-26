class User < ApplicationRecord
  before_save :downcase_email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  private

  def downcase_email
    self.email = email.downcase
  end
end
