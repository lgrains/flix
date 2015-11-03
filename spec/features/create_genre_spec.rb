require "spec_helper"

describe "Creating a new genre" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "saves the genre and show the genre's name" do
    visit genres_url

    click_link "Add New Genre"

    expect(current_path).to eq(new_genre_path)

    fill_in "Name", with: "New Genre Name"

    click_button "Create Genre"

    expect(page).to have_text("Genre successfully created!")
    expect(current_path).to eq(genre_path(Genre.last))
  end

  it "doesn't save the genre if it's invalid" do
    visit new_genre_url

    expect {
      click_button "Create Genre"
    }.to_not change(Genre, :count)

    expect(current_path).to eq(genres_path)
    expect(page).to have_text("error")
  end
end
