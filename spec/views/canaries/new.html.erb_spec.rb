require 'rails_helper'

RSpec.describe "canaries/new", type: :view do
  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com")
    @team = Team.create(name: "Q&A")
    @alert_integration = AlertIntegration.create(kind: 'Slack', data: 'slack_url: foobar', name: 'Slack', team: @team)

    assign(:alert_integrations, [@alert_integration])
    assign(:teams, [@team])

    assign(:canary, Canary.new(
      :name => "MyString",
      :schedule => "MyString",
      :team => nil,
      :comment => "MyText",
      :uuid => "MyString",
      :created_by => nil
    ))
  end

  it "renders new canary form" do
    render
    assert_select "form[action=?][method=?]", canaries_path, "post" do
      assert_select "input#canary_name[name=?]", "canary[name]"
      assert_select "select#canary_schedule[name=?]", "canary[schedule]"
      assert_select "select#canary_team_id[name=?]", "canary[team_id]"
      assert_select "textarea#canary_comment[name=?]", "canary[comment]"
      assert_select "select#canary_alert_integration_id[name=?]", "canary[alert_integration_id]"
    end
  end
end
