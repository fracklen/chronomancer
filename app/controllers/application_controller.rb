class ApplicationController < ActionController::Base
  # rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
  #   render :text => exception, :status => 500
  # end
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_authorizor

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def authorize_admin
    return true if authorizor.admin?
    render json: {status: "Unauthorized!", reason: "Admin access required"}, status: 403
  end

  def set_authorizor
    @authorizor = Authorizor.new(current_user)
  end

  def authorizor
    @authorizor
  end

  def event(agg_type, event_type, event_params, model)
    {
      initiator: current_user.username,
      event_type: "#{agg_type}_#{event_type}",
      event_params: event_params.to_h,
      aggregate_id: "#{agg_type}_#{model.id}"
    }
  end

end
