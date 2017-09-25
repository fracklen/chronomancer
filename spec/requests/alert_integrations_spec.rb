require 'rails_helper'

RSpec.describe "AlertIntegrations", type: :request do
  describe "GET /alert_integrations" do
    it "works! (now write some real specs)" do
      get alert_integrations_path
      expect(response).to have_http_status(200)
    end
  end
end
