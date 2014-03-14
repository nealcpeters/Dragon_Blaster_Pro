require 'spec_helper'

feature 'Map displays' do
  context "on user's map's homepage" do
    it "not see a list of user's maps without being logged in" do
      user = User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
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

      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      # visit "/users/#{map.creator_id}/maps"
      click_link("My Maps")
      expect(page).to have_content("#{map.title}")
    end
  end

  context "on all maps page" do
    it "sees a list of all created maps" do
      User.create(username: 'abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
      map = Map.create(starting_room_id: 1, creator_id: 1, title: 'map', description: 'a map for all maps')
      visit "/all_maps"
      expect(page).to have_content("#{map.title}")
    end
  end

  context "create link works" do
    xit "taken to create map page" do
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

    it "deletes a user's maps when click delete" do
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

      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      # visit "/users/#{map.creator_id}/maps"
      click_link("My Maps")
      expect {
        click_link("Delete")
        }.to change(Map, :count).by(-1)
    end

    it "should route to the edit page when a user clicks edit" do
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

      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      # visit "/users/#{map.creator_id}/maps"
      click_link("My Maps")
      click_link("Edit")
      expect(page).to have_content("TEST CHECK")
    end
  end

  context "Neal and Eric are awesome. " do
    it "Yep. They most certainly are." do
      expect("duh" == "duh").to eq true
    end
  end

  context "can click link to view a map on all maps page" do
    it "should show map title" do
      visit "/users/new"

      expect {
         fill_in 'user_username', with: "abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"
       }.to change(User, :count).by(1)

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')

      visit "/all_maps"

      click_link("#{map.title}")

      expect(page).to have_content("#{map.title}")
    end

    it "should show map description" do
      visit "/users/new"

      expect {
         fill_in 'user_username', with: "abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"
       }.to change(User, :count).by(1)

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')

      visit "/all_maps"

      click_link("#{map.title}")

      expect(page).to have_content("#{map.description}")
    end

    it "should show map creator username" do
      visit "/users/new"

      expect {
         fill_in 'user_username', with: "abed"
         fill_in 'user_email', with: "abed@greendale.com"
         fill_in 'user_password', with: "password"
         fill_in 'user_password_confirmation', with: "password"
         click_button "Create User"
       }.to change(User, :count).by(1)

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')

      visit "/all_maps"

      click_link("#{map.title}")

      expect(page).to have_content("#{user.username}")
    end
    
    
  end
end
