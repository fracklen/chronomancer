class CheckinController < ActionController::Base
  def create
    CheckinJob.perform_later(
      params[:team_id],
      params[:id],
      Time.zone.now.to_s,
      request.user_agent,
      request.ip,
      params[:message]
    )
  end
end
