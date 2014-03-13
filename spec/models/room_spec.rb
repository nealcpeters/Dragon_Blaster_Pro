require 'spec_helper'

describe Room do

  it "should create valid room" do
    expect{
      User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(title: 'bob', description: 'fun fun fun')
    }.to change(Room, :count).by(1)
  end

  it "Will not create a room without a description" do
    expect{
      User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(title: 'bob')
    }.to change(Room, :count).by(0)
  end

  it "Will not create a room without a description" do
    expect{
      User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(description: 'bob')
    }.to change(Room, :count).by(0)
  end

  it "method #room_to_the_west returns id of room to the west" do
    room = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(title: 'bob', description: 'fun fun fun')
    room2 = User.first.maps.first.rooms.create(title: 'bob', west_id: "#{room.id}", description: 'fun fun fun')
    expect(room2.room_to_the_west == room).to eq true
  end

  it "method #room_to_the_east returns id of room to the east" do
    room = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(title: 'bob', description: 'fun fun fun')
    room2 = User.first.maps.first.rooms.create(title: 'bob', east_id: "#{room.id}", description: 'fun fun fun')
    expect(room2.room_to_the_east == room).to eq true
  end

  it "method #room_to_the_north returns id of room to the north" do
    room = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(title: 'bob', description: 'fun fun fun')
    room2 = User.first.maps.first.rooms.create(title: 'bob', north_id: "#{room.id}", description: 'fun fun fun')
    expect(room2.room_to_the_north == room).to eq true
  end

  it "method #room_to_the_south returns id of room to the south" do
    room = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(title: "Dreamatorium", starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!').rooms.create(title: 'bob', description: 'fun fun fun')
    room2 = User.first.maps.first.rooms.create(title: 'bob', south_id: "#{room.id}", description: 'fun fun fun')
    expect(room2.room_to_the_south == room).to eq true
  end

end
