require 'rails_helper'

RSpec.describe User, type: :model do
  it "can create a basic user" do
    @user = User.create(
      username: 'Foobar',
      email: 'baz@bar.dk',
    )
    expect(@user).to be_persisted
  end

  it "can create an admin user" do
    @user = User.create(
      username: 'Foobar',
      email: 'baz@bar.dk',
      admin: true
    )
    expect(@user).to be_persisted
  end
end
