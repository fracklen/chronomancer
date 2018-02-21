class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :ldap_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable,
  #       :authentication_keys => [:username]
  devise :omniauthable, omniauth_providers: %i(github)

  has_and_belongs_to_many :teams

  accepts_nested_attributes_for :teams

  before_validation :generate_api_key

  def generate_api_key
    if self.api_key.blank?
      self.api_key = SecureRandom.hex(32)
    end
  end

  def self.from_omniauth(auth)
    Rails.logger.warn("auth: #{auth.inspect}")
    Rails.logger.warn("info: #{auth.info.inspect}")
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      #user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      user.admin = User.count < 1
    end
    self.update_groups(auth.credentials.token, user)
    user
  end

  def self.update_groups(token, user)
    Rails.logger.warn("token: #{token}")
    client = Octokit::Client.new(access_token: token)
    client.orgs.each do |org|
      t = Team.where(name: org[:login]).first_or_create
      user.teams << t
    end
  end


end
