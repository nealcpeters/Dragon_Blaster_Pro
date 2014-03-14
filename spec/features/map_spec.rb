require 'spec_helper'

feature 'Map displays' do
  before :each do
    visit "/users/new"

    fill_in 'user_username', with: "abed"
    fill_in 'user_email', with: "abed@greendale.com"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"
    click_button "Create User"

      @user = User.find_by_username("abed")
      @map = Map.create(starting_room_id: 1, creator_id: @user.id, title: 'map', description: 'a map for all maps')
      @hero = Hero.create(player_id: User.find_by_username("abed").id, name: "tester", description: 'best game on earth')
      @room = Room.create(map_id: @map.id, title: "room title", description: "room description")
      @game = Game.create(player_id: @user.id, map_id: @map.id, room_id: @room.id, hero_id: @hero.id)
  end

  context "on user's map's homepage" do
    it "not see a list of user's maps without being logged in" do
      click_link("Sign-Out")
      visit "/users/#{@map.creator_id}/maps"
      expect(page).to have_no_content("#{@map.title}")
    end

    it "sees a list of user's maps when logged in" do
      click_link("My Maps")
      expect(page).to have_content("#{@map.title}")
    end
  end

  context "on all maps page" do
    it "sees a list of all created maps" do
      click_link("Games")
      expect(page).to have_content("#{@map.title}")
    end
  end

  context "create link works" do
    xit "taken to create map page" do
    visit "/users/new"

    fill_in 'user_username', with: "abed"
    fill_in 'user_email', with: "abed@greendale.com"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"
    click_button "Create User"

    user = User.find_by_username("abed")

      click_link("Create a Map")

      expect(page).to have_content("Gameboard here!")
    end

    it "deletes a user's maps when click delete" do
      click_link("My Maps")
      expect {
        click_link("Delete")
        }.to change(Map, :count).by(-1)
    end

    it "should route to the edit page when a user clicks edit" do
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
      visit "/all_games"
      expect(page).to have_content("#{@map.title}")
    end

    it "should show map description" do
      visit "/all_games"
      expect(page).to have_content("#{@map.description}")
    end

    it "should show map creator username" do
      visit "/all_games"
      expect(page).to have_content("#{@user.username}")
    end


  end
end
