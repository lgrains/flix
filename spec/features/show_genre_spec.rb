require "spec_helper"

describe "viewing an individual genre" do
  it "shows the genre name" do
    genre = Genre.create(name: "Genre Name")

    visit genre_url(genre)

    expect(page).to have_text(genre.name)
  end

  it "shows movies if there are any" do
    genre = Genre.create(name: "Genre Name")
    movie = genre.movies.create(movie_attributes)

    visit genre_url(genre)

    expect(page).to have_text("Movies")
    expect(page).to have_text("Iron Man")
  end
end
