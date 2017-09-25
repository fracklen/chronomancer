class CheckinJob < ActiveJob::Base
  queue_as :default

  def perform(team_id, uuid, timestamp, user_agent, ip, message)
    canary = Canary.where(uuid: uuid, team_id: team_id).first
    if canary.present?
      Checkin.create(canary: canary,
                     created_at: timestamp,
                     user_agent: user_agent,
                     ip: ip,
                     message: message)
      canary.update_expected_checkin(Time.parse(timestamp))
    end
  end
end
