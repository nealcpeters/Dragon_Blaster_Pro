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

end
