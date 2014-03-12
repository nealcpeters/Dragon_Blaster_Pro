require 'spec_helper'

feature 'Map displays' do
  context "on user's map's homepage" do
    it "not see a list of user's maps without being logged in" do
      User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: 1, title: 'map', description: 'a map for all maps')
      visit "/users/#{map.creator_id}/maps"
      expect(page).to have_no_content("#{map.title}")
    end

    it "sees a list of user's maps when logged in" do
      # user = User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      visit "/users/new"

      expect {
         fill_in 'user_username', with: "abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"
       }.to change(User, :count).by(1)

      user = User.find_by_username("abed")

      map = Map.create(creator_id: user.id, title: 'map', description: 'a map for all maps')
      # visit "/users/#{map.creator_id}/maps"
      click_link("My Maps")
      expect(page).to have_content("#{map.title}")
    end
  end

  context "on all maps page" do
    it "sees a list of all created maps" do
      User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(creator_id: 1, title: 'map', description: 'a map for all maps')
      visit "/all_maps"
      expect(page).to have_content("#{map.title}")
    end
  end

  context "create link works" do
    it "taken to create map page" do
      visit "/users/new"

      expect {
         fill_in 'user_username', with: "abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"
       }.to change(User, :count).by(1)

      user = User.find_by_username("abed")

      click_link("Create a Map")

      expect(page).to have_content("Gameboard here!")
    end
  end

  context "Neal and Eric are awesome. " do
    it "Yep. They most certainly are." do
      expect("duh" == "duh").to eq true
    end
  end
end
