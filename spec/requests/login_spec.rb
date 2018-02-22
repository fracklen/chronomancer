require 'rails_helper'

RSpec.describe "Login", type: :feature do
  describe "GET /teams" do
    let(:mock_kitten) { double(:kitten, orgs: [{login: 'The A-Team'}]) }

    before do
      allow(Octokit::Client).to receive(:new).and_return(mock_kitten)
    end

    it "can login in" do
      visit '/'
      click_link "Login"
      expect(page).to have_content("Successfully authenticated")  # user name
      expect(User.count).to eq 1
    end
  end
end
