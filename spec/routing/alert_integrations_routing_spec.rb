require "rails_helper"

RSpec.describe AlertIntegrationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/alert_integrations").to route_to("alert_integrations#index")
    end

    it "routes to #new" do
      expect(:get => "/alert_integrations/new").to route_to("alert_integrations#new")
    end

    it "routes to #show" do
      expect(:get => "/alert_integrations/1").to route_to("alert_integrations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/alert_integrations/1/edit").to route_to("alert_integrations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/alert_integrations").to route_to("alert_integrations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/alert_integrations/1").to route_to("alert_integrations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/alert_integrations/1").to route_to("alert_integrations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/alert_integrations/1").to route_to("alert_integrations#destroy", :id => "1")
    end

  end
end
