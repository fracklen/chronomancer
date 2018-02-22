class ApplicationSettingsController < ApplicationController
  before_action :set_application_setting, only: [:show, :edit, :update, :destroy]

  # GET /application_settings
  # GET /application_settings.json
  def index
    @application_settings = ApplicationSetting.all
  end

  # GET /application_settings/1
  # GET /application_settings/1.json
  def show
  end

  # GET /application_settings/new
  def new
    @application_setting = ApplicationSetting.new
  end

  # GET /application_settings/1/edit
  def edit
  end

  # POST /application_settings
  # POST /application_settings.json
  def create
    @application_setting = ApplicationSetting.new(application_setting_params)

    respond_to do |format|
      if @application_setting.save
        format.html { redirect_to @application_setting, notice: 'Application setting was successfully created.' }
        format.json { render :show, status: :created, location: @application_setting }
      else
        format.html { render :new }
        format.json { render json: @application_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /application_settings/1
  # PATCH/PUT /application_settings/1.json
  def update
    respond_to do |format|
      if @application_setting.update(application_setting_params)
        format.html { redirect_to @application_setting, notice: 'Application setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @application_setting }
      else
        format.html { render :edit }
        format.json { render json: @application_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_settings/1
  # DELETE /application_settings/1.json
  def destroy
    @application_setting.destroy
    respond_to do |format|
      format.html { redirect_to application_settings_url, notice: 'Application setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_setting
      @application_setting = ApplicationSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_setting_params
      params.require(:application_setting).permit(:key, :value)
    end
end
