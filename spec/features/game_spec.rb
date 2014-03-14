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

  context "game launch page" do

    it "displays created heroess" do
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

      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')

      visit "/all_maps"

      click_link("#{map.title}")

      click_link("Play Game")

      expect(page).to have_content(hero.name)
    end

    it "displays create hero link" do
      visit "/users/new"

      fill_in 'user_username', with: "abed"
      fill_in 'user_email', with: "abed@greendale.com"
      fill_in 'user_password', with: "password"
      fill_in 'user_password_confirmation', with: "password"
      click_button "Create User"

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')

      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')

      visit "/all_maps"

      click_link("#{map.title}")

      click_link("Play Game")

      expect(page).to have_content("Create Hero")
    end
 
  end

  context "games page" do

    it "displays map title" do
      visit "/users/new"

      fill_in 'user_username', with: "abed"
      fill_in 'user_email', with: "abed@greendale.com"
      fill_in 'user_password', with: "password"
      fill_in 'user_password_confirmation', with: "password"
      click_button "Create User"

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      room_north = Room.create(map_id: map.id, title: 'bob', description: 'fun fun fun')
      room = Room.create(map_id: map.id, title: 'bob', description: 'fun fun fun', north_id: room_north.id)

      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      map.starting_room_id = room.id
      map.save

      visit "/all_maps"

      click_link("#{map.title}")

      click_link("Play Game")

      page.choose 'hero_name_tester'

      click_button "Play Game"      

      expect(page).to have_content("Welcome to #{map.title}")
    end

    it "input of 'east' moves hero to the east" do
      visit "/users/new"

      fill_in 'user_username', with: "abed"
      fill_in 'user_email', with: "abed@greendale.com"
      fill_in 'user_password', with: "password"
      fill_in 'user_password_confirmation', with: "password"
      click_button "Create User"

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      room_east = Room.create(map_id: map.id, title: 'it went east', description: 'fun fun fun')
      room = Room.create(map_id: map.id, title: 'bob', description: 'fun fun fun', east_id: room_east.id)
      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      map.starting_room_id = room.id
      map.save

      visit "/all_maps"

      click_link("#{map.title}")

      click_link("Play Game")

      page.choose 'hero_name_tester'

      click_button "Play Game"      

      fill_in 'user_input', with: "east"

      click_button "Submit"

      expect(page).to have_content("#{room_east.title}")

      
    end

    it "input of 'west' moves hero to the west" do
      visit "/users/new"

      fill_in 'user_username', with: "abed"
      fill_in 'user_email', with: "abed@greendale.com"
      fill_in 'user_password', with: "password"
      fill_in 'user_password_confirmation', with: "password"
      click_button "Create User"

      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      room_west = Room.create(map_id: map.id, title: 'it went west', description: 'fun fun fun')
      room = Room.create(map_id: map.id, title: 'bob', description: 'fun fun fun', west_id: room_west.id)
      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      map.starting_room_id = room.id
      map.save

      visit "/all_maps"

      click_link("#{map.title}")

      click_link("Play Game")

      page.choose 'hero_name_tester'

      click_button "Play Game"      

      fill_in 'user_input', with: "west"

      click_button "Submit"

      expect(page).to have_content("#{room_west.title}")

      
    end

  end

end