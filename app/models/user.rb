class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  has_and_belongs_to_many :teams

  accepts_nested_attributes_for :teams

  before_validation :generate_api_key

  def generate_api_key
    if self.api_key.blank?
      self.api_key = SecureRandom.hex(32)
    end
  end
end
