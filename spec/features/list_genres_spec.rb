require "spec_helper"

describe "Viewing the list of genres" do
  it "shows the genres" do
    genre1 = Genre.create!(name: "Genre 1")
    genre2 = Genre.create!(name: "Genre 2")
    genre3 = Genre.create!(name: "Genre 3")

    visit genres_url

    expect(page).to have_text(genre1.name)
    expect(page).to have_text(genre2.name)
    expect(page).to have_text(genre3.name)
  end
end
