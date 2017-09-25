class AlertJob < ActiveJob::Base
  queue_as :default

  include ActionView::Helpers::DateHelper

  def perform(canary_id, alert_integration_id)
    canary = Canary.find(canary_id)
    alert_integration = AlertIntegration.find(alert_integration_id)

    case alert_integration.kind
    when 'Slack'
      notify_slack(canary, alert_integration)
    when 'PagerDuty'
      notify_pager_duty(canary, alert_integration)
    end
    Alert.create(canary: canary, kind: alert_integration.kind)
  end

  def notify_slack(canary, alert_integration)
    @data = integration_data(alert_integration)
    notifier = Slack::Notifier.new @data[:webhook_url],
      channel: @data[:channel],
      username: @data[:username]
    notifier.ping message(canary)
  end

  def notify_pager_duty(canary, alert_integration)
  end

  def message(canary)
    "WARNING! Recurring job #{canary.name} not seen" +
    " for #{distance_of_time_in_words(canary.last_checkin, Time.zone.now)}" +
    " - Should check in #{canary.schedule}"
  end

  def integration_data(alert_integration)
    YAML.load(alert_integration.data)
  end
end
