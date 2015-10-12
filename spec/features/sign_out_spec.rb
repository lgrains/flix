require 'spec_helper'

describe "Signing out" do

  it "removes the user id from the session" do
    user = User.create!(user_attributes)

    sign_in(user)

    click_link 'Sign Out'

    expect(page).to have_text("signed out")
    expect(page).not_to have_link('Sign Out')
    expect(page).to have_link('Sign In')
  end

  it "automatically signs out that user" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_path(user)

    click_link 'Delete Account'

    expect(page).to have_link('Sign In')
    expect(page).not_to have_link('Sign Out')
  end
end
