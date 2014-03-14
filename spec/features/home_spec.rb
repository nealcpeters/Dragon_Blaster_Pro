require 'spec_helper'

feature 'Home Page' do
  before :each do 
      visit "/"    
  end

  context "visibility" do
    scenario "has a functional existing user link" do
      click_link "Existing User?"
      expect(page).to have_content("Login")
    end

    scenario "has a functional new user link" do
      click_link "New User?"
      expect(page).to have_content("Sign Up")
    end

  end
end