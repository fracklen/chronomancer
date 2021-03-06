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

RSpec.describe CanariesController, type: :controller do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CanariesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    @user = User.create!(username: 'Admin A', email: 'foobar@baz.dk', admin: true)
    @team = Team.create!(name: 'The A-Team')
    @user.teams = [@team]
    @user.save
    login_with @user
  end

  # This should return the minimal set of attributes required to create a valid
  # Canary. As you add validations to Canary, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Foobar',
      schedule: 'EVERY_15_MINUTES',
      team: @team,
      comment: '',
      alert_integration_id: nil,
      created_by: @user
    }
  }

  let(:invalid_attributes) {
    {
      name: '',
      schedule: nil,
      team_id: nil,
      comment: nil,
      alert_integration_id: nil
    }
  }

  describe "GET #index" do
    it "assigns all canaries as @canaries" do
      canary = Canary.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:canaries)).to eq([canary])
    end
  end

  describe "GET #show" do
    it "assigns the requested canary as @canary" do
      canary = Canary.create! valid_attributes
      get :show, params: {id: canary.to_param}, session: valid_session
      expect(assigns(:canary)).to eq(canary)
    end
  end

  describe "GET #new" do
    it "assigns a new canary as @canary" do
      get :new, params: {}, session: valid_session
      expect(assigns(:canary)).to be_a_new(Canary)
    end
  end

  describe "GET #edit" do
    it "assigns the requested canary as @canary" do
      canary = Canary.create! valid_attributes
      get :edit, params: {id: canary.to_param}, session: valid_session
      expect(assigns(:canary)).to eq(canary)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) do
        {
          name: 'CanCanary',
          schedule: 'EVERY_15_MINUTES',
          team_id: @team.id,
          comment: '',
          alert_integration_id: nil,
          created_by_id: @user.id
        }
      end

      it "creates a new Canary" do
        expect {
          post :create, params: {canary: valid_attributes}, session: valid_session
        }.to change(Canary, :count).by(1)
      end

      it "assigns a newly created canary as @canary" do
        post :create, params: {canary: valid_attributes}, session: valid_session
        expect(assigns(:canary).errors).to be_empty
        expect(assigns(:canary)).to be_a(Canary)
        expect(assigns(:canary)).to be_persisted
      end

      it "redirects to the created canary" do
        post :create, params: {canary: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Canary.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved canary as @canary" do
        post :create, params: {canary: invalid_attributes}, session: valid_session
        expect(assigns(:canary)).to be_a_new(Canary)
      end

      it "re-renders the 'new' template" do
        post :create, params: {canary: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'Foobar',
          schedule: 'EVERY_3_HOURS',
          team_id: @team.id,
          comment: '',
          alert_integration_id: nil,
          created_by_id: @user.id
        }
      }

      it "updates the requested canary" do
        canary = Canary.create! valid_attributes
        put :update, params: {id: canary.to_param, canary: new_attributes}, session: valid_session
        canary.reload
        expect(canary.schedule).to eq('EVERY_3_HOURS')
      end

      it "assigns the requested canary as @canary" do
        canary = Canary.create! valid_attributes
        put :update, params: {id: canary.to_param, canary: valid_attributes}, session: valid_session
        expect(assigns(:canary)).to eq(canary)
      end

      it "redirects to the canary" do
        canary = Canary.create! valid_attributes
        put :update, params: {id: canary.to_param, canary: valid_attributes}, session: valid_session
        expect(response).to redirect_to(canary)
      end
    end

    context "with invalid params" do
      it "assigns the canary as @canary" do
        canary = Canary.create! valid_attributes
        put :update, params: {id: canary.to_param, canary: invalid_attributes}, session: valid_session
        expect(assigns(:canary)).to eq(canary)
      end

      it "re-renders the 'edit' template" do
        canary = Canary.create! valid_attributes
        put :update, params: {id: canary.to_param, canary: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested canary" do
      canary = Canary.create! valid_attributes
      expect {
        delete :destroy, params: {id: canary.to_param}, session: valid_session
      }.to change(Canary, :count).by(-1)
    end

    it "redirects to the canaries list" do
      canary = Canary.create! valid_attributes
      delete :destroy, params: {id: canary.to_param}, session: valid_session
      expect(response).to redirect_to(canaries_url)
    end
  end

end
