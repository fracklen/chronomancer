require 'rails_helper'

RSpec.describe "application_settings/edit", type: :view do
  before(:each) do
    @application_setting = assign(:application_setting, ApplicationSetting.create!(
      :key => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit application_setting form" do
    render

    assert_select "form[action=?][method=?]", application_setting_path(@application_setting), "post" do

      assert_select "input#application_setting_key[name=?]", "application_setting[key]"

      assert_select "input#application_setting_value[name=?]", "application_setting[value]"
    end
  end
end
