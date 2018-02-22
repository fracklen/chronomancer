require 'rails_helper'

RSpec.describe "application_settings/index", type: :view do
  before(:each) do
    assign(:application_settings, [
      ApplicationSetting.create!(
        :key => "Key",
        :value => "Value"
      ),
      ApplicationSetting.create!(
        :key => "Key",
        :value => "Value"
      )
    ])
  end

  it "renders a list of application_settings" do
    render
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
