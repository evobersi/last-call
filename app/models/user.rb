class User < ActiveRecord::Base
  has_secure_password(validations: false)
  validates_uniqueness_of :email
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true

  # Custom Password validations
  validates :password, presence: true, length: { minimum: 6 }, on: :create, if: :not_using_omniauth
  validates_presence_of :password_confirmation, if: lambda { |m| m.password.present? }
  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  private

  def not_using_omniauth
    oauth_token.nil?
  end
end
