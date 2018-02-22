require 'rails_helper'

RSpec.describe "canaries/index", type: :view do
  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com")
    @team = Team.create(name: "Q&A")
    assign(:canaries, [
      Canary.create!(
        :name => "Name",
        :schedule => "EVERY_15_MINUTES",
        :team => @team,
        :comment => "MyText",
        :uuid => "Uuid",
        :created_by => @user
      ),
      Canary.create!(
        :name => "Name2",
        :schedule => "EVERY_HOUR",
        :team => @team,
        :comment => "MyText",
        :uuid => "Uuid2",
        :created_by => @user
      )
    ])
  end

  it "renders a list of canaries" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Name2".to_s, :count => 1
    assert_select "tr>td", :text => "EVERY_15_MINUTES".to_s, :count => 1
    assert_select "tr>td", :text => "EVERY_HOUR".to_s, :count => 1
    assert_select "tr>td", :text => 'Q&A'.to_s, :count => 2
  end
end
