# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  before(:each) do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: "asd", password_confirmation: "asd")
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: "asd", password_confirmation: "asd")
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: "asd", password_confirmation: "asd")
  end
  describe 'When I visit a movie show page', :vcr do
    it 'I see a button to create a viewing party' do
      visit movie_path(@user_1.id, 25)

      expect(page).to have_button('Create Viewing Party for Jarhead')
      click_button('Create Viewing Party for Jarhead')

      expect(current_path).to eq(new_party_path(@user_1.id, 25))
    end

    it 'has a button to return to the discover page', :vcr do
      visit movie_path(@user_1.id, 104)

      expect(page).to have_button('Discover Page')
      click_button('Discover Page')

      expect(current_path).to eq(discover_path(@user_1.id))
    end

    it 'displays the movie title, vote average, runtime, genre, and summary', :vcr do
      visit movie_path(@user_1.id, 25)

      expect(page).to have_content('Jarhead')
      within '#movie_info' do
        expect(page).to have_content('Vote: 6.617')
        expect(page).to have_content('Runtime: 2hr 3min')
        expect(page).to have_content('Drama')
        expect(page).to have_content('War')
        expect(page).to have_content('Jarhead is a film about a US Marine')
      end
    end

    it 'displays 10 cast members and their role', :vcr do
      visit movie_path(@user_1.id, 25)

      within '#cast' do
        expect(page).to have_content('Jake Gyllenhaal as Anthony Swofford')
        expect(page).to have_content('Jamie Foxx as Staff Sgt. Sykes')
        expect(page).to have_content('Peter Sarsgaard as Alan Troy')
        expect(page).to have_content('Chris Cooper as Lt. Col. Kazinski')
      end
    end

    it 'displays the count of reviews and all reviews with author', :vcr do
      visit movie_path(@user_1.id, 569_094)

      within '#reviews' do
        expect(page).to have_content('8 Reviews')
        expect(page).to have_content('garethmb')
        expect(page).to have_content('Life as a teenager is never easy')
      end
    end
  end
end
