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


  end
end
