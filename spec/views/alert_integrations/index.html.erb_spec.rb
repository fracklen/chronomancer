require 'rails_helper'

RSpec.describe "alert_integrations/index", type: :view do
  before(:each) do
    assign(:alert_integrations, [
      AlertIntegration.create!(
        :team => nil,
        :kind => "Kind",
        :data => "MyText"
      ),
      AlertIntegration.create!(
        :team => nil,
        :kind => "Kind",
        :data => "MyText"
      )
    ])
  end

  it "renders a list of alert_integrations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
