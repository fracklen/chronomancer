class Api::CanariesController < ApiController

  def create
    return unless valid_membership?
    @canary = Canary.create(
      name: params[:name],
      schedule: params[:schedule],
      uuid: params[:uuid] || SecureRandom.uuid,
      team_id: params[:team_id],
      alert_integration_id: params[:alert_integration_id],
      comment: params[:comment],
      created_by: current_api_user
    )
    if @canary.errors.any?
      render json: { errors: @canary.errors }
    else
      render json: @canary
    end
  end

  def index
    render json: current_api_user.teams.include(:canaries)
  end

  def destroy
    if Canary.where('canaries.uuid' => params[:id]).any?
      Canary.where(uuid: params[:id]).first.destroy
      render json: {return: 'OK'}
    else
      render json: { errors: ["Not found"]}, status: 404
    end
  end

  private

    def valid_membership?
      return true if current_api_user.teams.pluck(:id).include?(params[:team_id])
      render json: { errors: ['You are not on that team!']}
      return false
    end
end
