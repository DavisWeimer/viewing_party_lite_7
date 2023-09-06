require 'rails_helper'

RSpec.describe 'User Login' do
  describe 'When I visit the welcome page' do
    before do
      @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: "asd", password_confirmation: "asd")
    end
    it 'I can login an existing user' do
      visit root_path

      click_button "Log In"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Log In")

      expect(current_path).to eq(login_path)
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_on "Log In"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{@user_1.name}!")
    end

    it 'I cannnot login if I enter incorrect password' do
      visit root_path

      click_button "Log In"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Log In")

      expect(current_path).to eq(login_path)
      fill_in :email, with: @user_1.email
      fill_in :password, with: "41414144"
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, incorrect credentials.")
    end

    it 'I cannnot login if I enter incorrect password' do
      visit root_path

      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Log In")

      expect(current_path).to eq(login_path)
      fill_in :email, with: "eeqrueiguqief"
      fill_in :password, with: @user_1.password
      click_on "Log In"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, incorrect credentials.")
    end

    it "as user, no button_to Log In or Create an Account but a button_to to Log Out" do
      visit root_path

      expect(page).to have_button("Create New User")
      expect(page).to have_button("Log In")
      expect(page).to_not have_button("Log Out")
      click_button "Log In"
      
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Log In")
      
      expect(current_path).to eq(login_path)
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_on "Log In"
      
      expect(current_path).to eq(root_path)
      expect(page).to_not have_button("Create New User")
      expect(page).to_not have_button("Log In")
      expect(page).to have_button("Log Out")
      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_button("Create New User")
      expect(page).to have_button("Log In")
      expect(page).to have_content("Logged Out!")
    end
  end
end