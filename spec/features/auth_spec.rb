require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  before(:each) { visit("/users/new") }

  it "has a new user page" do
    expect(page).to have_content "Create New Account"
  end
  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in("Username", with: "Jie")
      fill_in("Password", with: "password")
      click_on("Create User")
      expect(page).to have_content "Jie"
    end
  end

end

feature "logging in" do

  before(:each) do
    User.create!(
      username: "Jie",
      password: "password"
    )
    visit("/session/new")
    fill_in("Username", with: "Jie")
    fill_in("Password", with: "password")
    click_on("Log In")
  end

  it "shows username on the homepage after login" do

    expect(page).to have_content("Jie")
  end

end

feature "logging out" do
  before(:each) do
    User.create!(
      username: "Jie",
      password: "password"
    )
    visit("/session/new")
  end


  it "begins with logged out state" do
    expect(current_path).to eq("/session/new")
  end

  it "doesn't show username on the homepage after logout" do
    fill_in("Username", with: "Jie")
    fill_in("Password", with: "password")
    click_on("Log In")
    click_on("Sign Out")
    expect(page).to_not have_content("Jie")
  end

end
