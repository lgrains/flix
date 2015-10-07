require 'spec_helper'

describe "Viewing a user's profile page" do

  it "shows the user's details" do
    user = User.create!(user_attributes)

    visit user_url(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
    expect(page).to have_text("Member Since")
    expect(page).to have_text(user.created_at.strftime("%B %Y"))
  end
end
