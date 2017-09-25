require 'rails_helper'

RSpec.describe "canaries/edit", type: :view do
  before(:each) do
    @user = User.create(username: "tester", email: "test@test.com", password: "testtest")
    @team = Team.create(name: "Q&A")
    assign(:canary, Canary.create!(
      :name => "Name",
      :schedule => "EVERY_15_MINUTES",
      :team => @team,
      :comment => "MyText",
      :uuid => "Uuid",
      :created_by => @user
    )
    assign(:teams, [@team])


  end

  it "renders the edit canary form" do
    render

    assert_select "form[action=?][method=?]", canary_path(@canary), "post" do

      assert_select "input#canary_name[name=?]", "canary[name]"

      assert_select "input#canary_schedule[name=?]", "canary[schedule]"

      assert_select "input#canary_team_id[name=?]", "canary[team_id]"

      assert_select "textarea#canary_comment[name=?]", "canary[comment]"

      assert_select "input#canary_created_by_id[name=?]", "canary[created_by_id]"
    end
  end
end
