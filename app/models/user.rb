class User < ApplicationRecord
  before_save :downcase_email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :belongings
  has_many :groups, through: :belongings, dependent: :destroy
  has_many :posts

  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.username
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      if user.provider == "facebook"
        user.profile_photo = auth.info.profile_photo
      end
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
