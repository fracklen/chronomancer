require 'rails_helper'

RSpec.describe "application_settings/show", type: :view do
  before(:each) do
    @application_setting = assign(:application_setting, ApplicationSetting.create!(
      :key => "Key",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
  end
end
