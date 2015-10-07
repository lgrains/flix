# create_user_spec.rb

require 'spec_helper'

describe "Creating a new user" do
  it "saves the user and shows the user's profile page" do
    visit root_url

    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in "Name",  with: "Example User"
    fill_in "Username", with: "abcdef12345"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "p@ssw0rd"
    fill_in "Confirm Password", with: "p@ssw0rd"

    click_button 'Create Account'

    expect(current_path).to eq(user_path(User.last))

    expect(page).to have_text('Example User')
    expect(page).to have_text('Thanks for signing up!')
  end

  it "does not save the user if it's invalid" do
    visit signup_url

    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end
