# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "User Dashboard page '/users/:id'", type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Jimmy', email: 'movie_buff333@gmail.com', password: "asd", password_confirmation: "asd")
    @user_2 = User.create!(name: 'Timmy', email: 'i_hate_movies@gmail.com', password: "asd", password_confirmation: "asd")
    @user_3 = User.create!(name: 'Tammy', email: 'gamer4134@gmail.com', password: "asd", password_confirmation: "asd")
    @user_4 = User.create!(name: 'Sammy', email: 'moives_are_okay_i_guess@gmail.com', password: "asd", password_confirmation: "asd")

    @movie = Movie.new({
                         id: 321,
                         original_title: 'Mambo Italiano',
                         vote_average: 5.8,
                         runtime: 89,
                         genres: [{ id: 35, name: 'Comedy' }, { id: 10_749, name: 'Romance' }],
                         overview: 'When an Italian man comes out of the closet, it affects both his life and his crazy family.'
                       })

    @movie_2 = Movie.new({
                           id: 569_094,
                           original_title: 'Jarhead',
                           vote_average: 5.8,
                           runtime: 89,
                           genres: [{ id: 35, name: 'Comedy' }, { id: 10_749, name: 'Romance' }],
                           overview: 'When an Italian man comes out of the closet, it affects both his life and his crazy family.'
                         })

    @party_1 = Party.create!(duration: @movie.runtime, date: Date.today, time: Time.now, movie_id: @movie.id)
    @host = PartyUser.create!(user_id: @user_1.id, party_id: @party_1.id, host: true)
    PartyUser.create!(user_id: @user_2.id, party_id: @party_1.id, host: false)
    PartyUser.create!(user_id: @user_3.id, party_id: @party_1.id, host: false)

    @party_2 = Party.create!(duration: @movie_2.runtime, date: Date.today, time: Time.now, movie_id: @movie_2.id)
    @host_2 = PartyUser.create!(user_id: @user_2.id, party_id: @party_2.id, host: true)
    PartyUser.create!(user_id: @user_1.id, party_id: @party_2.id, host: false)
    PartyUser.create!(user_id: @user_3.id, party_id: @party_2.id, host: false)

    visit root_path

    click_button "Log In"
    fill_in :email, with: @user_1.email
    fill_in :password, with: @user_1.password
    click_on "Log In"
  end

  describe "When I visit a user's dashboard page", :vcr do
    it "Displays the user's name at the top of the page" do
      visit dashboard_path(@user_1.id)

      expect(page).to have_content("#{@user_1.name}'s Dashboard")
      expect(page).to_not have_content("#{@user_2.name}'s Dashboard")
      expect(page).to_not have_content("#{@user_3.name}'s Dashboard")
    end

    it 'Has a button to discover movies', :vcr do
      visit dashboard_path(@user_1.id)

      within '#discover_movies' do
        expect(page).to have_button('Discover Movies')
        click_button('Discover Movies')
      end
      expect(current_path).to eq(discover_path(@user_1.id))
      expect(current_path).to_not eq(discover_path(@user_2.id))
    end

    xit 'Has a section that lists viewing parties', :vcr do
      visit dashboard_path(@user_1.id)

      expect(page).to have_link('Mambo Italiano')
      expect(page).to have_content(@party_1.date.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(@party_1.time.strftime('%I:%M%p'))
      expect(page).to have_content('Hosting')

      expect(page).to have_link('Spider-Man: Across the Spider-Verse')
      expect(page).to have_content(@party_2.date.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(@party_2.time.strftime('%I:%M%p'))
      expect(page).to have_content('Invited')

      click_link('Spider-Man: Across the Spider-Verse')
      expect(current_path).to eq(movie_path(@user_2.id, @movie_2.id))
    end
  end
end
