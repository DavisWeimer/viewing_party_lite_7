# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Discover Movies page '/users/:id/discover'", type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: "asd")
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: "asd")
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: "asd")
  end

  describe "When I visit a user's discover movies page" do
    it 'Displays a button to find top rated movies', :vcr do
      visit discover_path(@user_1.id)

      within '#discover_top_movies' do
        expect(page).to have_button('Find Top Rated Movies')
        click_button('Find Top Rated Movies')
      end
      expect(current_path).to eq(movies_path(@user_1.id))
      expect(page).to have_content('Top Rated Movies')
    end

    it 'Displays a text field and button to search for a movie title', :vcr do
      visit discover_path(@user_2.id)

      within '#title_search' do
        expect(page).to have_field('Movie Title')
        expect(page).to have_button('Find Movies')
      end
    end
  end
end
