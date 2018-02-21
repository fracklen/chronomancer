class CheckinController < ActionController::Base
  def create
    CheckinJob.perform_later(
      params[:team_id],
      params[:id],
      Time.zone.now.to_s,
      request.user_agent,
      request.headers['HTTP_X_FORWARDED_FOR'] || request.remote_ip,
      params[:message]
    )
  end
end
