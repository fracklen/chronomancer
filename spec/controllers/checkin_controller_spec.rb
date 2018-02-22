require 'rails_helper'

RSpec.describe CheckinController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create, params: {team_id: 42, id: 'abcd-1234'}
      expect(response).to have_http_status(:success)
    end
  end

end
