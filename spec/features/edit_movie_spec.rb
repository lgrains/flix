require 'spec_helper'

describe "Editing a movie" do
  before do
    @genre1 = Genre.create!(name: "Genre 1")
    @genre2 = Genre.create!(name: "Genre 2")
    @genre3 = Genre.create!(name: "Genre 3")

    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "updates the movie and shows the movie's updated details" do
    movie = Movie.create(movie_attributes)
    movie.genres << @genre1
    movie.genres << @genre2

    visit movie_url(movie)
    click_link 'Edit'

    expect(current_path).to eq(edit_movie_path(movie))
    expect(find_field('Title').value).to eq(movie.title)

    fill_in 'Title', with: "Updated Movie Title"
    uncheck(@genre1.name)
    check(@genre3.name)
    click_button 'Update Movie'

    expect(page).to have_text('Movie successfully updated!')
    expect(current_path).to eq(movie_path(movie))
    expect(page).to have_text('Updated Movie Title')
    expect(page).to have_text(@genre2.name)
    expect(page).to have_text(@genre3.name)
    expect(page).to_not have_text(@genre1.name)
  end

  it "does not update the movie if it's invalid" do
    movie = Movie.create(movie_attributes)

    visit edit_movie_url(movie)
    fill_in 'Title', with: " "
    click_button 'Update Movie'

    expect(page).to have_text('error')
  end
end
