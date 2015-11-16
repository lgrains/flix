require 'spec_helper'

describe "Viewing a user's profile page" do

  it "shows the user's details" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
    expect(page).to have_text("Member Since")
    expect(page).to have_text(user.created_at.strftime("%B %Y"))
  end

  it "shows the user's favorites in the sidebar" do
    user = User.create!(user_attributes)

    movie = Movie.create!(movie_attributes)
    user.favorite_movies << movie

    sign_in(user)

    visit user_url(user)

    within("aside#sidebar") do
      expect(page).to have_text(movie.title)
    end
  end

  it "includes the user's name in the page title" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    expect(page).to have_title("Flix - #{user.name}")
  end
end
