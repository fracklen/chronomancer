require 'rails_helper'

RSpec.describe Api::CanariesController, type: :controller do

  before do
    @user = User.create!(username: 'Admin A', email: 'foobar@baz.dk', admin: true)
    @team = Team.create!(name: 'The A-Team')
    @user.teams = [@team]
    @user.save
  end

  let(:headers) do
    {
      'HTTP_X_API_KEY' => @user.api_key
    }
  end


  describe "GET #create" do
    it "returns http success" do
      request.headers.merge! headers
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      request.headers.merge! headers
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    before do
      @canary = Canary.create!(name: 'Foo',
        schedule: 'EVERY_15_MINUTES',
        team: @team,
        created_by: @user,
        uuid: SecureRandom.uuid
      )
    end

    it "returns http success" do
      request.headers.merge! headers
      delete :destroy, params: { id: @canary.uuid }
      expect(response).to have_http_status(:success)
    end
  end

end
