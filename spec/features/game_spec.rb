require 'spec_helper'

feature 'Hero routes' do
  before :each do
    visit "/users/new"
    fill_in 'user_username', with: "abed"
    fill_in 'user_email', with: "abed@greendale.com"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"
    click_button "Create User"
  end

  context "on user homepage" do
    it "see link to view heroes" do
      expect(page).to have_content("Check out your Heroes")
    end

  end

  context "on view heroes page" do
    it "leads to a link where you can see heroes" do
      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      click_link "Check out your Heroes"
      expect(page).to have_content("tester")
    end
  end

  context "game launch page" do

    it "displays created heroes" do
      user = User.find_by_username("abed")
      map = Map.create(starting_room_id: 1, creator_id: user.id, title: 'map', description: 'a map for all maps')
      hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      room = Room.create(map_id: map.id, title: "room title", description: "room description")
      game = Game.create(player_id: user.id, map_id: map.id, room_id: room.id, hero_id: hero.id)
      visit "/all_games"

      expect(page).to have_content(hero.name)
    end

    it "displays create hero page" do
      click_link "Check out your Heroes"
      click_link "Make a New Hero"

      expect(page).to have_content("Create a new hero")
    end

  end

  context "games page" do
    before :each do
      @user = User.find_by_username("abed")
      @map = Map.create(starting_room_id: 1, creator_id: @user.id, title: 'map', description: 'a map for all maps')
      @hero = Hero.create(player_id: @user.id, name: "tester", description: 'best game on earth')
    end



    it "displays map title" do
      room = Room.create(map_id: @map.id, title: "room title", description: "room description")
      game = Game.create(player_id: @user.id, map_id: @map.id, room_id: room.id, hero_id: @hero.id)
      visit "/all_games"

      expect(page).to have_content("#{@map.title}")
    end

    it "input of 'east' moves hero to the east" do
      room_east = Room.create(map_id: @map.id, title: 'it went east', description: 'fun fun fun')
      room = Room.create(map_id: @map.id, title: 'bob', description: 'fun fun fun', east_id: room_east.id)
      game = Game.create(player_id: @user.id, map_id: @map.id, room_id: room.id, hero_id: @hero.id)
      @map.starting_room_id = room.id
      @map.save

      visit "/all_games"
      click_button("Continue Game")
      fill_in 'user_input', with: "east"
      click_button "Submit"
      expect(page).to have_content("#{room_east.title}")

    end

    it "input of 'west' moves hero to the west" do

      room_west = Room.create(map_id: @map.id, title: 'it went east', description: 'fun fun fun')
      room = Room.create(map_id: @map.id, title: 'bob', description: 'fun fun fun', west_id: room_west.id)
      game = Game.create(player_id: @user.id, map_id: @map.id, room_id: room.id, hero_id: @hero.id)
      @map.starting_room_id = room.id
      @map.save

      visit "/all_games"
      click_button("Continue Game")
      fill_in 'user_input', with: "west"
      click_button "Submit"
      expect(page).to have_content("#{room_west.title}")
    end

    it "input of 'north' moves hero to the north" do
      room_north = Room.create(map_id: @map.id, title: 'it went east', description: 'fun fun fun')
      room = Room.create(map_id: @map.id, title: 'bob', description: 'fun fun fun', north_id: room_north.id)
      game = Game.create(player_id: @user.id, map_id: @map.id, room_id: room.id, hero_id: @hero.id)
      @map.starting_room_id = room.id
      @map.save

      visit "/all_games"
      click_button("Continue Game")
      fill_in 'user_input', with: "north"
      click_button "Submit"
      expect(page).to have_content("#{room_north.title}")
    end

    it "input of 'south' moves hero to the south" do

      room_south = Room.create(map_id: @map.id, title: 'it went east', description: 'fun fun fun')
      room = Room.create(map_id: @map.id, title: 'bob', description: 'fun fun fun', south_id: room_south.id)
      game = Game.create(player_id: @user.id, map_id: @map.id, room_id: room.id, hero_id: @hero.id)
      @map.starting_room_id = room.id
      @map.save

      visit "/all_games"
      click_button("Continue Game")
      fill_in 'user_input', with: "south"
      click_button "Submit"
      expect(page).to have_content("#{room_south.title}")
    end

    it "input of 'look' should make hero look at room" do
      room_south = Room.create(map_id: @map.id, title: 'it went east', description: 'fun fun fun')
      room = Room.create(map_id: @map.id, title: 'bob', description: 'fun fun fun', south_id: room_south.id)
      game = Game.create(player_id: @user.id, map_id: @map.id, room_id: room.id, hero_id: @hero.id)
      @map.starting_room_id = room.id
      @map.save

      visit "/all_games"
      click_button("Continue Game")
      fill_in 'user_input', with: "look"
      click_button "Submit"
      expect(page).to have_content("#{room.description}")
    end
  end
end
