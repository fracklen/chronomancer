require 'rails_helper'

RSpec.describe "alert_integrations/show", type: :view do
  before(:each) do
    @alert_integration = assign(:alert_integration, AlertIntegration.create!(
      :team => nil,
      :kind => "Kind",
      :data => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/MyText/)
  end
end
