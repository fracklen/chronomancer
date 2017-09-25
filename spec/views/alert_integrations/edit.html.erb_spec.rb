require 'rails_helper'

RSpec.describe "alert_integrations/edit", type: :view do
  before(:each) do
    @alert_integration = assign(:alert_integration, AlertIntegration.create!(
      :team => nil,
      :kind => "MyString",
      :data => "MyText"
    ))
  end

  it "renders the edit alert_integration form" do
    render

    assert_select "form[action=?][method=?]", alert_integration_path(@alert_integration), "post" do

      assert_select "input#alert_integration_team_id[name=?]", "alert_integration[team_id]"

      assert_select "input#alert_integration_kind[name=?]", "alert_integration[kind]"

      assert_select "textarea#alert_integration_data[name=?]", "alert_integration[data]"
    end
  end
end
