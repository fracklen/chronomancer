require 'rails_helper'

RSpec.describe "canaries/edit", type: :view do
  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com")
    @team = Team.create(name: "Q&A")
    @alert_integration = AlertIntegration.create(kind: 'Slack', data: 'slack_url: foobar', name: 'Slack', team: @team)
    @canary = Canary.create(
      :name => "Name",
      :schedule => "EVERY_15_MINUTES",
      :team => @team,
      :comment => "MyText",
      :alert_integration => @alert_integration,
      :uuid => "Uuid",
      :created_by => @user
    )
    assign(:canary, @canary)
    assign(:alert_integrations, [@alert_integration])
    assign(:teams, [@team])


  end

  it "renders the edit canary form" do
    render
      assert_select "form[action=?][method=?]", canary_path(@canary), "post" do
      assert_select "input#canary_name[name=?]", "canary[name]"
      assert_select "select#canary_schedule[name=?]", "canary[schedule]"
      assert_select "select#canary_team_id[name=?]", "canary[team_id]"
      assert_select "textarea#canary_comment[name=?]", "canary[comment]"
      assert_select "select#canary_alert_integration_id[name=?]", "canary[alert_integration_id]"
    end
  end
end
