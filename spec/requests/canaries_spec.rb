require 'rails_helper'

RSpec.describe "Canaries", type: :feature do
  describe "GET /canaries" do
    let(:mock_kitten) { double(:kitten, orgs: [{login: 'The A-Team'}]) }

    before do
      allow(Octokit::Client).to receive(:new).and_return(mock_kitten)
      visit '/'
      click_link "Login"
    end

    it "works! (now write some real specs)" do
      visit canaries_path
      expect(page).to have_http_status(200)
    end
  end
end
