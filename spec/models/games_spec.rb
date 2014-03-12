require 'spec_helper'

describe Game do

  it "should create valid game" do
    expect{
      Game.create(player_id: 1, map_id: 1)
    }.to change(Game, :count).by(1)
  end

  it "should not create game without valid player_id" do
    expect{
      Game.create(map_id: 1)
    }.to change(Game, :count).by(0)
  end

  it "should not create game without valid map_id" do
    expect{
      Game.create(player_id: 1)
    }.to change(Game, :count).by(0)
  end
end
