require 'rails_helper'

RSpec.describe "application_settings/new", type: :view do
  before(:each) do
    assign(:application_setting, ApplicationSetting.new(
      :key => "MyString",
      :value => "MyString"
    ))
  end

  it "renders new application_setting form" do
    render

    assert_select "form[action=?][method=?]", application_settings_path, "post" do

      assert_select "input#application_setting_key[name=?]", "application_setting[key]"

      assert_select "input#application_setting_value[name=?]", "application_setting[value]"
    end
  end
end
