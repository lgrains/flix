require "spec_helper"

describe "Navigating genres" do
    before do
      admin = User.create!(user_attributes(admin: true))
      sign_in(admin)
    end

    it "allows navigation from the detail page to the listing page" do
      genre = Genre.create!(name: "Genre 1")

      visit(genre_url(genre))
      click_link "All Genres"

      expect(current_path).to eq(genres_path)
    end

    it "allows navigation from the listing page to the detail page" do
      genre = Genre.create!(name: "Genre 1")

      visit genres_url
      click_link "Genre 1"

      expect(current_path).to eq(genre_path(genre))
    end
end
