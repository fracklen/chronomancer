require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe AlertIntegrationsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # AlertIntegration. As you add validations to AlertIntegration, be sure to
  # adjust the attributes here as well.
  let(:alert_data) do
    "---\nwebhook_url: http://value\nchannel: foo\nusername: bar"
  end
  let(:valid_attributes) {
    {
      name: 'Slack Foobar',
      kind: 'Slack',
      team: @team,
      data: alert_data
    }
  }

  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com")
    @team = Team.create(name: "Q&A")
    @user.teams = [@team]
    @user.save
    @team.reload
    login_with @user
  end


  let(:invalid_attributes) {
    {
      name: 'Barred',
      kind: 'Slack',
      team_id: @team.id,
      data: ''
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AlertIntegrationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all alert_integrations as @alert_integrations" do
      alert_integration = AlertIntegration.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:alert_integrations)).to eq([alert_integration])
    end
  end

  describe "GET #show" do
    it "assigns the requested alert_integration as @alert_integration" do
      alert_integration = AlertIntegration.create! valid_attributes
      get :show, params: {id: alert_integration.id}, session: valid_session
      expect(assigns(:alert_integration)).to eq(alert_integration)
    end
  end

  describe "GET #new" do
    it "assigns a new alert_integration as @alert_integration" do
      get :new, params: {}, session: valid_session
      expect(assigns(:alert_integration)).to be_a_new(AlertIntegration)
    end
  end

  describe "GET #edit" do
    it "assigns the requested alert_integration as @alert_integration" do
      alert_integration = AlertIntegration.create! valid_attributes
      get :edit, params: {id: alert_integration.to_param}, session: valid_session
      expect(assigns(:alert_integration)).to eq(alert_integration)
    end
  end

  describe "POST #create" do
    let(:valid_attributes) {
      {
        name: 'Slack Foobar',
        kind: 'Slack',
        team_id: @team.id,
        data: alert_data
      }
    }
    context "with valid params" do

      it "creates a new AlertIntegration" do
        expect {
          post :create, params: {alert_integration: valid_attributes}, session: valid_session
        }.to change(AlertIntegration, :count).by(1)
      end

      it "assigns a newly created alert_integration as @alert_integration" do
        post :create, params: {alert_integration: valid_attributes}, session: valid_session
        expect(assigns(:alert_integration)).to be_a(AlertIntegration)
        expect(assigns(:alert_integration)).to be_persisted
      end

      it "redirects to the created alert_integration" do
        post :create, params: {alert_integration: valid_attributes}, session: valid_session
        expect(response).to redirect_to(AlertIntegration.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved alert_integration as @alert_integration" do
        post :create, params: {alert_integration: invalid_attributes}, session: valid_session
        expect(assigns(:alert_integration)).to be_a_new(AlertIntegration)
      end

      it "re-renders the 'new' template" do
        post :create, params: {alert_integration: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'Slack Foobar 42',
          kind: 'Slack',
          team_id: @team.id,
          data: alert_data
        }
      }

      it "updates the requested alert_integration" do
        alert_integration = AlertIntegration.create! valid_attributes
        put :update, params: {id: alert_integration.to_param, alert_integration: new_attributes}, session: valid_session
        alert_integration.reload
        expect(alert_integration.name).to eq('Slack Foobar 42')
      end

      it "assigns the requested alert_integration as @alert_integration" do
        alert_integration = AlertIntegration.create! valid_attributes
        put :update, params: {id: alert_integration.to_param, alert_integration: valid_attributes}, session: valid_session
        expect(assigns(:alert_integration)).to eq(alert_integration)
      end

      it "redirects to the alert_integration" do
        alert_integration = AlertIntegration.create! valid_attributes
        put :update, params: {id: alert_integration.to_param, alert_integration: valid_attributes}, session: valid_session
        expect(response).to redirect_to(alert_integration)
      end
    end

    context "with invalid params" do
      it "assigns the alert_integration as @alert_integration" do
        alert_integration = AlertIntegration.create! valid_attributes
        put :update, params: {id: alert_integration.to_param, alert_integration: invalid_attributes}, session: valid_session
        expect(assigns(:alert_integration)).to eq(alert_integration)
      end

      it "re-renders the 'edit' template" do
        alert_integration = AlertIntegration.create! valid_attributes
        put :update, params: {id: alert_integration.to_param, alert_integration: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested alert_integration" do
      alert_integration = AlertIntegration.create! valid_attributes
      expect {
        delete :destroy, params: {id: alert_integration.to_param}, session: valid_session
      }.to change(AlertIntegration, :count).by(-1)
    end

    it "redirects to the alert_integrations list" do
      alert_integration = AlertIntegration.create! valid_attributes
      delete :destroy, params: {id: alert_integration.to_param}, session: valid_session
      expect(response).to redirect_to(alert_integrations_url)
    end
  end

end
