require 'spec_helper'

describe User do
  it "Attr Reader works on username" do
    user = User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
    expect(user.username == user.username).to eq true
  end

  it "Will not validate mismatched passwords" do
    expect{
      User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'suck it trebek')
    }.to change(User, :count).by(0)
  end

  it "Will not validate bad email" do
    expect{
      User.create(username: 'Abed', email: 'abed@greendale', password: 'password', password_confirmation: 'password')
    }.to change(User, :count).by(0)
  end

  it "Will not validate non-unique username" do
    User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
    expect{
      User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
    }.to change(User, :count).by(0)
  end

end
