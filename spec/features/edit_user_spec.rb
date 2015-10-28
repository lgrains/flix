# edit_user_spec.rb

require 'spec_helper'

describe "Editing a user" do

  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it "updates the user and shows the user's updated details" do
    visit user_url(@user)

    click_link 'Edit Account'

    expect(current_path).to eq(edit_user_path(@user))

    expect(find_field('Name').value).to eq(@user.name)

    fill_in "Name", with: "Updated User Name"

    click_button "Update Account"

    expect(current_path).to eq(user_path(@user))

    expect(page).to have_text("Updated User Name")
    expect(page).to have_text('Account successfully updated!')
  end

  it "does not update the user if it's invalid" do
    visit edit_user_url(@user)

    fill_in 'Name', with: " "

    click_button "Update Account"

    expect(page).to have_text('error')
  end

end
