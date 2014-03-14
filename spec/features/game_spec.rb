require 'spec_helper'

feature 'Hero routes' do
  context "on user homepage" do
    it "see link to view heroes" do
      visit "/users/new"
      fill_in 'user_username', with: "abed"
      fill_in 'user_email', with: "abed@greendale.com"
      fill_in 'user_password', with: "password"
      fill_in 'user_password_confirmation', with: "password"
      click_button "Create User"
      expect(page).to have_content("Check out your Heroes")
    end

  end

  context "on view heroes page" do
    it "leads to a link where you can see heroes" do
      visit "/users/new"
      fill_in 'user_username', with: "abed"
      fill_in 'user_email', with: "abed@greendale.com"
      fill_in 'user_password', with: "password"
      fill_in 'user_password_confirmation', with: "password"
      click_button "Create User"
      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      click_link "Check out your Heroes"
      expect(page).to have_content("tester")      
    end

  end

end