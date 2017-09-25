class CanariesController < ApplicationController
  before_action :set_canary, only: [:show, :edit, :update, :destroy]
  before_action :set_dependencies
  before_action :set_checkins, only: [:show]
  before_action :set_alerts, only: [:show]

  # GET /canaries
  # GET /canaries.json
  def index
    @canaries = Canary.joins(team: :users).where('users.id' => current_user.id)
  end

  # GET /canaries/1
  # GET /canaries/1.json
  def show
  end

  # GET /canaries/new
  def new
    @canary = Canary.new
  end

  # GET /canaries/1/edit
  def edit
  end

  # POST /canaries
  # POST /canaries.json
  def create
    @canary = Canary.new(canary_params)
    @canary.created_by = current_user
    @canary.uuid = SecureRandom.uuid

    respond_to do |format|
      if @canary.save
        format.html { redirect_to @canary, notice: 'Canary was successfully created.' }
        format.json { render :show, status: :created, location: @canary }
      else
        format.html { render :new }
        format.json { render json: @canary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /canaries/1
  # PATCH/PUT /canaries/1.json
  def update
    respond_to do |format|
      if @canary.update(canary_params)
        format.html { redirect_to @canary, notice: 'Canary was successfully updated.' }
        format.json { render :show, status: :ok, location: @canary }
      else
        format.html { render :edit }
        format.json { render json: @canary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /canaries/1
  # DELETE /canaries/1.json
  def destroy
    @canary.checkins.delete_all
    @canary.alerts.delete_all
    @canary.destroy
    respond_to do |format|
      format.html { redirect_to canaries_url, notice: 'Canary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_canary
      @canary = Canary
        .joins(team: :users)
        .where('users.id' => current_user.id)
        .find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def canary_params
      params.require(:canary).permit(:name, :schedule, :team_id, :comment, :alert_integration_id)
    end

    def set_dependencies
      @teams = current_user.teams.includes(:alert_integrations)
      @alert_integrations = @teams.flat_map { |team| team.alert_integrations }
    end

    def set_checkins
      @checkins = @canary.checkins.order('created_at DESC').last(20)
    end

    def set_alerts
      @alerts = @canary.alerts.order('created_at DESC').last(20)
    end
end
