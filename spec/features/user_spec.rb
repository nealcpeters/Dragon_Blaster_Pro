require 'spec_helper'

feature 'Users' do
  context "User account creation" do
    it "should create a new user" do
      visit "/users/new"

      expect {
         fill_in 'user_username', with: "abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"
       }.to change(User, :count).by(1)
    end
  end

  context "User account login" do
    it "should login a user" do
      user = User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      visit "/sessions/new"

      fill_in 'username', with: "abed"
      fill_in 'password', with: "password"
      click_button "Log in"
      expect(page).to have_content("#{user.username}")
    end
  end

  context "User account logout" do
    it "should log a user out" do
      user = User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      visit "/sessions/new"

      fill_in 'username', with: "abed"
      fill_in 'password', with: "password"
      click_button "Log in"

      click_link "Sign-Out"
      expect(page).to have_content("Logged out!")
    end
  end

end
