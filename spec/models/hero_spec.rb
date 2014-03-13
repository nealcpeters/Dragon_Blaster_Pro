require 'spec_helper'

describe Hero do
  it "should create valid hero" do
    expect{
      Hero.create(room_id: 1, game_id: 1, player_id: 1, name: 'abed', description: 'best game on earth')
    }.to change(Hero, :count).by(1)
  end

  it "should not create valid hero without valid room_id" do
    expect{
      Hero.create(game_id: 1, player_id: 1, name: 'abed', description: 'best game on earth')
    }.to change(Hero, :count).by(0)
  end

  it "should not create valid hero without valid game_id" do
    expect{
      Hero.create(room_id: 1, player_id: 1, name: 'abed', description: 'best game on earth')
    }.to change(Hero, :count).by(0)
  end

  it "should not create valid hero without valid player_id" do
    expect{
      Hero.create(room_id: 1, game_id: 1, name: 'abed', description: 'best game on earth')
    }.to change(Hero, :count).by(0)
  end

  it "should not create valid hero without valid name" do
    expect{
      Hero.create(room_id: 1, game_id: 1, player_id: 1, description: 'best game on earth')
    }.to change(Hero, :count).by(0)
  end

  it "should not create valid hero without valid description" do
    expect{
      Hero.create(room_id: 1, game_id: 1, player_id: 1, name: 'abed')
    }.to change(Hero, :count).by(0)
  end

  context "movement methods" do

    it "#move_hero_north shouldl move hero north" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_north = User.first.maps.first.rooms.create(title: 'bob', north_id: "#{room.id}", description: 'fun fun fun')
      # room_to_east = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_south = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_west = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{@room.id}", description: 'fun fun fun')
      hero = Hero.create(room_id: "#{room_to_north.id}", game_id: 1, player_id: 1, name: 'abed')
      hero.move_hero_north
      expect(hero.room_id == room.id).to be true
    end

    it "#move_hero_north shouldl move hero south" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_south = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{room.id}", description: 'fun fun fun')
      # room_to_east = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_south = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_west = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{@room.id}", description: 'fun fun fun')
      hero = Hero.create(room_id: "#{room_to_south.id}", game_id: 1, player_id: 1, name: 'abed')
      hero.move_hero_south
      expect(hero.room_id == room.id).to be true
    end

    it "#move_hero_north shouldl move hero east" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_east = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{room.id}", description: 'fun fun fun')
      # room_to_east = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_south = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_west = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{@room.id}", description: 'fun fun fun')
      hero = Hero.create(room_id: "#{room_to_east.id}", game_id: 1, player_id: 1, name: 'abed')
      hero.move_hero_east
      expect(hero.room_id == room.id).to be true
    end

    it "#move_hero_north shouldl move hero west" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_west = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{room.id}", description: 'fun fun fun')
      # room_to_east = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_south = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{@room.id}", description: 'fun fun fun')
      # room_to_west = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{@room.id}", description: 'fun fun fun')
      hero = Hero.create(room_id: "#{room_to_west.id}", game_id: 1, player_id: 1, name: 'abed')
      hero.move_hero_west
      expect(hero.room_id == room.id).to be true
    end


  end

end
