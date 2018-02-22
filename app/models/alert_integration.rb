class AlertIntegration < ApplicationRecord
  KINDS = %w(Slack PagerDuty Teams)
  has_many :canaries

  belongs_to :team

  SLACK_DEFAULTS = {
    webhook_url: 'https://slack.com/foobar/uuid',
    channel:     'Ops',
    username:    'Chronomancer'
  }

  validate :slack_valid

  validates_presence_of :name

  def read_data
    YAML.load(data).symbolize_keys
  end

  private
    def slack_valid
      return unless self.kind == 'Slack'
      begin
        read_data
      rescue => e
        errors.add(:data, "Invalid yaml: #{e}")
        return
      end
      SLACK_DEFAULTS.each do |key,_|
        if self.read_data[key].blank?
          errors.add(:data, "must include #{key}")
        end
      end
    end
end
