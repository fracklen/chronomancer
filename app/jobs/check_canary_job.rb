class CheckCanaryJob < ActiveJob::Base
  queue_as :default

  def perform(id)
    @canary = Canary.find(id)
    return unless @canary.last_checkin.present? && @canary.overdue?
    return if @canary.alerts.where('created_at > ?', @canary.silence.ago).any?
    if @canary.alert_integration.present?
      AlertJob.perform_later(@canary.id, @canary.alert_integration.id)
    else
      @canary.team.alert_integrations.each do |ai|
        AlertJob.perform_later(@canary.id, ai.id)
      end
    end
  end
end
