require 'spec_helper'

feature 'The Nav Bar' do
  context "visibility" do
    it "it should be seen" do
      visit "/"
      expect(page).to have_content("Dragon Blaster")
    end

    it "it should show logged in user name" do
      visit "/users/new"

         fill_in 'user_username', with: "Abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"


      expect(page).to have_content("Abed's Profile")
    end

    it "it should nav to profile page" do
      visit "/users/new"

         fill_in 'user_username', with: "Abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"

      click_link "Abed's Profile"
      expect(page).to have_content("Abed's Profile")
    end

    it "the title link should nav to home" do
      visit "/users/new"
      click_link "Dragon Blaster"
      expect(page).to have_content("Welcome to Dragon Blaster!")
    end

    it "the login link should nav to login screen" do
      visit "/"
      click_link "Sign-In"
      expect(page).to have_content("Login")
    end

    it "the register link should nav to sign up screen" do
      visit "/"
      click_link "Register"
      expect(page).to have_content("Sign Up")
    end
  end
end
