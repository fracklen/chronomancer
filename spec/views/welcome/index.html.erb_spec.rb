require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Welcome/)
  end
end
