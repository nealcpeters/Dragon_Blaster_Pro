require 'spec_helper'

describe Map do
  it "Attr Reader works on title" do
  map = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create( starting_room_id: 1, title: 'Dreamatorium', description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
  expect(map.title == map.title).to eq true
  end

  it "Will not validate empty title" do
    expect{
      map = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create( starting_room_id: 1, description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
    }.to change(Map, :count).by(0)
  end

  it "Will not validate empty description" do
    expect{
      map = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password').maps.create(starting_room_id: 1, title: 'Where we play Professor Spacetime and make dreams come true. Come join us!', starting_room_id: 1)
    }.to change(Map, :count).by(0)
  end

  it "Will not validate without user" do
    expect{
      Map.create( starting_room_id: 1, title: 'Dreamatorium', description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
    }.to change(Map, :count).by(0)
  end

  it "Will not validate without starting room id" do
    expect{
      Map.create(title: 'Dreamatorium', description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
    }.to change(Map, :count).by(0)
  end

end
