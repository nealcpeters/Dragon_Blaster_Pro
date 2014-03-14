require 'spec_helper'

feature 'Home Page' do
  context "visibility" do
    it "has a functional existing user link" do
      visit "/"
      click_link "Existing User?"
      expect(page).to have_content("Login")
    end

    it "has a functional new user link" do
      visit "/"
      click_link "New User?"
      expect(page).to have_content("Sign Up")
    end

  end
end