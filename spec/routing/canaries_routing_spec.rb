require "rails_helper"

RSpec.describe CanariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/canaries").to route_to("canaries#index")
    end

    it "routes to #new" do
      expect(:get => "/canaries/new").to route_to("canaries#new")
    end

    it "routes to #show" do
      expect(:get => "/canaries/1").to route_to("canaries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/canaries/1/edit").to route_to("canaries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/canaries").to route_to("canaries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/canaries/1").to route_to("canaries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/canaries/1").to route_to("canaries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/canaries/1").to route_to("canaries#destroy", :id => "1")
    end

  end
end
