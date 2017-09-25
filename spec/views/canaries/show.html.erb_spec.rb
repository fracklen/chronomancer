require 'rails_helper'

RSpec.describe "canaries/show", type: :view do
  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com", password: "testtest")
    @team = Team.create(name: "Q&A")
    @canary = assign(:canary, Canary.create!(
      :name => "Name",
      :schedule => "EVERY_15_MINUTES",
      :team => @team,
      :comment => "MyText",
      :uuid => "Uuid",
      :created_by => @user
    ))
    assign(:checkins, [])
    assign(:alerts, [])
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Schedule/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(//)
  end
end
