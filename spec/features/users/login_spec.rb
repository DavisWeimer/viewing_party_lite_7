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
  end
end