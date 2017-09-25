class ApiController < ActionController::Base
  before_action :authenticate_api_user

  def authenticate_api_user
    @current_api_user = User.where(api_key: request.headers['HTTP_X_API_KEY']).first
    return true if @current_api_user.present? && request.headers['HTTP_X_API_KEY'].present?
    render json: { permission: 'denied'}, status: 401
  end

  def current_api_user
    @current_api_user || nil
  end
end
