require 'rails_helper'

RSpec.describe "alert_integrations/index", type: :view do
  let(:alert_data) do
    "---\nwebhook_url: http://value\nchannel: foo\nusername: bar"
  end

  before(:each) do
    @team = Team.create(name: "Q&A")
    assign(:alert_integrations, [
      AlertIntegration.create!(
      team: @team,
      name: "Foobar",
      kind: "Slack",
      data: alert_data
    ),
      AlertIntegration.create!(
        team: @team,
        name: "Foobar2",
        kind: "Slack",
        data: alert_data
      )
    ])
  end

  it "renders a list of alert_integrations" do
    render
    assert_select "tr>td", text: "Foobar", count: 1
    assert_select "tr>td", text: "Foobar2", count: 1
    assert_select "tr>td", text: "Slack", count: 2
  end
end
