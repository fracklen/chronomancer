class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user_authorizor, only: [:show, :edit, :update, :index]
  before_action :set_dependencies, only: [:new, :create, :show, :edit, :update, :destroy]

  before_action :authorize_admin

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.all
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
    @user_authorizor = Authorizor.new(@user)
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(user_params)
    @user.password = "CONTROLLED BY LDAP"
    @user_authorizor = Authorizor.new(@user)
    respond_to do |format|
      if @user.save
        #EventEmitterJob.perform_later(event(:user, :created, user_params, @user))
        handle_memberships
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @user.update(update_user_params)
        #EventEmitterJob.perform_later(event(:user, :updated, user_params, @user))
        handle_memberships
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    handle_memberships
    @user.destroy
    #EventEmitterJob.perform_later(event(:user, :destroyed, params, @user))
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def handle_memberships
      @user.teams.where.not(id: team_ids).each do |team|
        @user.teams.delete(team)
      end
      (team_ids - @user.teams.pluck(:id)).each do |team_id|
        @user.teams << Team.find(team_id)
      end
    end

    def set_user_authorizor
      @user_authorizor = Authorizor.new(@user)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_dependencies
      @teams = Team.all
      if @user
        @memberships = @user.teams
      else
        @memberships = []
      end
    end

    def team_ids
      (params[:user][:team_ids] || []).map(&:to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :name, :email, :admin, :team_ids)
    end

    def update_user_params
      # Don't allow username to change!
      params.require(:user).permit(:name, :email, :admin)
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
