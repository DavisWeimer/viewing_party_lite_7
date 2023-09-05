# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Movie Results Page '/users/:id/movies'", type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: "asd", password_confirmation: "asd")
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: "asd", password_confirmation: "asd")
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: "asd", password_confirmation: "asd")
  end

  describe 'top rated movies' do
    it 'displays top 20 rated movies', :vcr do
      visit discover_path(@user_1.id)
      click_button('Find Top Rated Movies')

      expect(page).to have_content('Top Rated Movies')
      within '#top_movies' do
        expect(current_path).to eq(movies_path(@user_1.id))
        expect(page).to have_link('The Godfather')
        expect(page).to have_content('Vote Average: 8.7')
      end
    end

    it 'displays top 20 movies by search query', :vcr do
      visit discover_path(@user_1.id)
      fill_in :title, with: 'Jack'
      click_button 'Find Movies'

      expect(page).to have_content('Top Rated Movies')
      within '#top_movies' do
        expect(current_path).to eq(movies_path(@user_1.id))
        expect(page).to have_link('Jack')
        expect(page).to have_content('7.0')
      end
    end

    it 'displays a button to return to the Discover page', :vcr do
      visit discover_path(@user_1.id)
      click_button('Find Top Rated Movies')
      expect(page).to have_button('Discover Page')

      click_button('Discover Page')
      expect(current_path).to eq(discover_path(@user_1.id))
    end
  end
end
