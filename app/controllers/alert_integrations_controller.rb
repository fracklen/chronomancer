class AlertIntegrationsController < ApplicationController
  before_action :set_alert_integration, only: [:show, :edit, :update, :destroy]
  before_action :set_teams

  # GET /alert_integrations
  # GET /alert_integrations.json
  def index
    @alert_integrations = AlertIntegration.all
    return if authorizor.admin?

    @alert_integrations = AlertIntegration
      .joins(team: :users)
      .where('users.id' => current_user.id)
      .all
  end

  # GET /alert_integrations/1
  # GET /alert_integrations/1.json
  def show
  end

  # GET /alert_integrations/new
  def new
    @alert_integration = AlertIntegration.new
    @alert_integration.data = AlertIntegration::SLACK_DEFAULTS.to_yaml
  end

  # GET /alert_integrations/1/edit
  def edit
  end

  # POST /alert_integrations
  # POST /alert_integrations.json
  def create
    @alert_integration = AlertIntegration.new(alert_integration_params)
    if !authorizor.admin? && @alert_integration.team.users.where('users.id' => current_user.id).empty?
      render file: "public/401.html", status: :unauthorized
      return
    end
    respond_to do |format|
      if @alert_integration.save
        format.html { redirect_to @alert_integration, notice: 'Alert integration was successfully created.' }
        format.json { render :show, status: :created, location: @alert_integration }
      else
        format.html { render :new }
        format.json { render json: @alert_integration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alert_integrations/1
  # PATCH/PUT /alert_integrations/1.json
  def update
    respond_to do |format|
      if @alert_integration.update(alert_integration_params)
        format.html { redirect_to @alert_integration, notice: 'Alert integration was successfully updated.' }
        format.json { render :show, status: :ok, location: @alert_integration }
      else
        format.html { render :edit }
        format.json { render json: @alert_integration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alert_integrations/1
  # DELETE /alert_integrations/1.json
  def destroy
    @alert_integration.destroy
    respond_to do |format|
      format.html { redirect_to alert_integrations_url, notice: 'Alert integration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert_integration
      if authorizor.admin?
        @alert_integration = AlertIntegration.find(params[:id])
      else
        @alert_integration = AlertIntegration
          .joins(team: :users)
          .where('users.id' => current_user.id)
          .find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_integration_params
      params.require(:alert_integration).permit(:name, :team_id, :kind, :data)
    end

    def set_teams
      if authorizor.admin?
        @teams = Team.all
      else
        @teams = current_user.teams
      end
    end
end
