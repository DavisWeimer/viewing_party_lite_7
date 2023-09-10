# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page', type: :feature do
  before :each do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: "asd", password_confirmation: "asd")
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: "asd", password_confirmation: "asd")
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: "asd", password_confirmation: "asd")
    @user_4 = User.create!(name: 'Sammy', email: 'moives_are_okay_i_guess@gmail.com', password: "asd", password_confirmation: "asd")
  end
  describe '#index' do
    it 'displays the title of the application' do
      visit root_path

      expect(page).to have_content('Viewing Party!')
    end

    it 'has a button to create a new user' do
      visit root_path

      within '#new_user' do
        expect(page).to have_button('Create New User')
        click_button('Create New User')
      end
      expect(current_path).to eq(register_path)
    end

    it 'displays a list of existing users emails' do
      visit root_path
      within '#existing_users_emails' do
        expect(page).to have_content('movie_buff333@gmail.com')
        expect(page).to have_content('i_hate_movies@gmail.com')
        expect(page).to have_content('gamer4134@gmail.com')
      end
    end

    it 'has a home link on every page' do
      visit root_path
      click_link('Home')
      expect(current_path).to eq(root_path)

      visit dashboard_path(@user_1.id)
      click_link('Home')
      expect(current_path).to eq(root_path)
    end
  end
  describe "Login redirect" do
    it "does not allow users dashboard access without logging in" do
      visit root_path

      visit dashboard_path(@user_1.id)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Please log in or register to access this page.")
    end
  end
end
