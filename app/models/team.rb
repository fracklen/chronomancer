class Team < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :alert_integrations
  has_many :canaries

  accepts_nested_attributes_for :users
end
