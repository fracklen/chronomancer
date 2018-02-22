require 'rails_helper'

RSpec.describe Team, type: :model do
  it "can create a team" do
    @team = Team.create(name: 'Foobar')
    expect(@team).to be_persisted
  end

  it "can add users to team" do
    @team = Team.create(name: 'Foobar')
    @user = User.create(username: 'BOFH', email: 'bofh@admin.org')
    @user.teams << @team
    expect(@team.reload.users).to include(@user)
  end

  it 'cant create team without name' do
    expect {
      Team.create!(name: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'cant create team with duplicate name' do
    Team.create!(name: 'Duplicati')
    expect {
      Team.create!(name: 'Duplicati')
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
