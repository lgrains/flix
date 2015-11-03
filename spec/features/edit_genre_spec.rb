require "spec_helper"

describe "Editing a genre" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "updates the genre name" do
    genre = Genre.create(name: "Genre Name")
    visit genre_url(genre)
    click_link "Edit"

    expect(current_path).to eq(edit_genre_path(genre))
    expect(find_field("Name").value).to eq(genre.name)

    fill_in "Name", with: "Updated Genre Name"
    click_button "Update Genre"

    expect(page).to have_text("Genre successfully updated!")
    expect(current_path).to eq(genre_path(genre))
    expect(page).to have_text("Updated Genre Name")
  end

  it "doesn't update the genre if it's invalid" do
    genre = Genre.create(name: "Genre Name")

    visit edit_genre_url(genre)
    fill_in "Name", with: " "
    click_button "Update Genre"

    expect(page).to have_text("error")
  end
end
