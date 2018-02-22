require 'rails_helper'

RSpec.describe "alert_integrations/show", type: :view do
  let(:alert_data) do
    "---\nwebhook_url: http://value\nchannel: foo\nusername: bar"
  end

  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com")
    @team = Team.create(name: "Q&A")
    @alert_integration = assign(:alert_integration, AlertIntegration.create!(
      :team => @team,
      :name => "Foobar",
      :kind => "MyString",
      :data => alert_data
    ))
    assign(:teams, [@team])
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/webhook_url/)
  end
end
