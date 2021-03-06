require 'spec_helper'

describe Hero do
  it "should create valid hero" do
    expect{
      Hero.create(player_id: 1, name: 'abed', description: 'best game on earth')
    }.to change(Hero, :count).by(1)
  end

  it "should not create valid hero without valid player_id" do
    expect{
      Hero.create(name: 'abed', description: 'best game on earth')
    }.to change(Hero, :count).by(0)
  end

  it "should not create valid hero without valid name" do
    expect{
      Hero.create(player_id: 1, description: 'best game on earth')
    }.to change(Hero, :count).by(0)
  end

  it "should not create valid hero without valid description" do
    expect{
      Hero.create(player_id: 1, name: 'abed')
    }.to change(Hero, :count).by(0)
  end


end
