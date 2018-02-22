require 'rails_helper'

RSpec.describe "alert_integrations/new", type: :view do
  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com")
    @team = Team.create(name: "Q&A")
    @alert_integration = assign(:alert_integration, AlertIntegration.new)
    assign(:teams, [@team])
  end

  it "renders new alert_integration form" do
    render

    assert_select "form[action=?][method=?]", alert_integrations_path, "post" do

      assert_select "select#alert_integration_team_id[name=?]", "alert_integration[team_id]"

      assert_select "select#alert_integration_kind[name=?]", "alert_integration[kind]"

      assert_select "textarea#alert_integration_data[name=?]", "alert_integration[data]"
    end
  end
end
