# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'When I visit the user registration page' do
    it 'can create a new user' do
      visit register_path
      username = "Billy"
      email = "billy_Boy@gmail.com"
      password = "le password"
      fill_in :user_name, with: username
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password
      click_button 'Register'

      user = User.last
      expect(current_path).to eq(dashboard_path(user.id))
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it "can't create a new user with invalid data" do
      visit register_path
      username = ""
      email = "billy_Boy@gmail.com"
      password = "12333"
      fill_in :user_name, with: username
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Please fill in all fields.")
    end

    it "can't create a new user if passwords entered do not match" do
      visit register_path
      username = "Biff"
      email = "biff_BBBB@gmail.com"
      password = "12333"
      fill_in :user_name, with: username
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: "woops"
      click_button 'Register'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password and confirmation do not match!")
    end
  end
end
