require 'rails_helper'

RSpec.describe "canaries/new", type: :view do
  before(:each) do
    assign(:canary, Canary.new(
      :name => "MyString",
      :schedule => "MyString",
      :team => nil,
      :comment => "MyText",
      :uuid => "MyString",
      :created_by => nil
    ))
  end

  it "renders new canary form" do
    render

    assert_select "form[action=?][method=?]", canaries_path, "post" do

      assert_select "input#canary_name[name=?]", "canary[name]"

      assert_select "input#canary_schedule[name=?]", "canary[schedule]"

      assert_select "input#canary_team_id[name=?]", "canary[team_id]"

      assert_select "textarea#canary_comment[name=?]", "canary[comment]"

      assert_select "input#canary_uuid[name=?]", "canary[uuid]"

      assert_select "input#canary_created_by_id[name=?]", "canary[created_by_id]"
    end
  end
end
