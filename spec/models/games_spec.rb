require 'spec_helper'

describe Game do

  it "should create valid game" do
    expect{
      Game.create(player_id: 1, map_id: 1, hero_id: 1, room_id: 1)
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
  context "movement methods" do

    it "#move_hero_north shouldl move hero north" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_north = User.first.maps.first.rooms.create(title: 'bob', north_id: "#{room.id}", description: 'fun fun fun')
      hero = Hero.create(player_id: 1, name: 'abed')
      game = Game.create(room_id: "#{room_to_north.id}", player_id: 1, hero_id: hero.id, map_id: map.id)
      game.move_hero_north
      expect(game.room_id == room.id).to be true
    end

    it "#move_hero_north shouldl move hero south" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_south = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{room.id}", description: 'fun fun fun')
      hero = Hero.create(player_id: 1, name: 'abed')
      game = Game.create(room_id: "#{room_to_south.id}", player_id: 1, hero_id: hero.id, map_id: map.id)
      game.move_hero_south
      expect(game.room_id == room.id).to be true
    end

    it "#move_hero_north shouldl move hero east" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_east = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{room.id}", description: 'fun fun fun')
      hero = Hero.create(player_id: 1, name: 'abed')
      game = Game.create(room_id: "#{room_to_east.id}", player_id: 1, hero_id: hero.id, map_id: map.id)
      game.move_hero_east
      expect(game.room_id == room.id).to be true
    end

    it "#move_hero_north shouldl move hero west" do
      user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: user.id.to_i, title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
      room = Room.create(map_id: map.id.to_i, title: 'bob', description: 'fun fun fun')
      room_to_west = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{room.id}", description: 'fun fun fun')
      hero = Hero.create(player_id: 1, name: 'abed')
      game = Game.create(room_id: "#{room_to_west.id}", player_id: 1, hero_id: hero.id, map_id: map.id)
      game.move_hero_west
      expect(game.room_id == room.id).to be true
    end


  end
end
