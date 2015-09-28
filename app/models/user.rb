class User < ActiveRecord::Base
  has_many :polls, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: [:user, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, :rememberable, :trackable, :validatable

  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info

    user = User.find_by(:provider => access_token.provider, :uid => access_token.uid)
    return user if user

    registered_user = User.find_by(:email => access_token.info.email)
    return registered_user if registered_user

    user = User.create(
      provider: access_token.provider,
      email: data["email"],
      uid: access_token.uid ,
      password: Devise.friendly_token[0,20],
    )
  end

  def self.find_for_database_authentication(warden_conditions)
    where(warden_conditions).where(is_active: true).first
  end

  def admin?
    role == 'admin'
  end
end
