require 'spec_helper'

describe "A user" do

  it "requires a name" do
    user = User.new(name: "")

    user.valid? # populates errors
    expect(user.errors[:name].any?).to eq(true)
  end

  it "requires an email" do
    user = User.new(email: "")

    user.valid?

    expect(user.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique, case insensitive email address" do
    user1 = User.create!(user_attributes)

    user2 = User.new(email: user1.email.upcase)
    user2.valid?
    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "accepts properly formatted usernames" do
    usernames = %w[username UsErNaMe user_name]

    usernames.each do |username|
      user = User.new(username: username)
      user.valid?
      expect(user.errors[:username].any?).to eq(false)
    end
  end

  it "rejects improperly formatted usernames" do
    usernames = %w[user\sname user#name @#$%^&*]

    usernames.each do |username|
      user = User.new(username: username)
      user.valid?
      expect(user.errors[:username].any?).to eq(true)
    end
  end

  it "requires a unique, case insensitive username" do
    user1 = User.create!(user_attributes)

    user2 = User.new(username: user1.username.upcase)
    user2.valid?
    expect(user2.errors[:username].first).to eq("has already been taken")
  end

  it "is valid with example attributes" do
    user = User.new(user_attributes)

    expect(user.valid?).to eq(true)
  end

  it "requires a password" do
    user = User.new(password: "")

    user.valid?

    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation when a password is present" do
    user = User.new(password: "p@ssw0rd", password_confirmation: "")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires the password to match the password confirmation" do
    user = User.new(password: "p@ssw0rd", password_confirmation: "nomatch")

    user.valid?

    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end

  it "requires a password and matching password confirmation when creating" do
    user = User.create!(user_attributes(password: "p@ssw0rd", password_confirmation: "p@ssw0rd"))

    expect(user.valid?).to eq(true)
  end

  it "does not require a password when updating" do
    user = User.create!(user_attributes)

    user.password = ""

    expect(user.valid?).to eq(true)
  end

  it "automatically encrypts the password into the password_digest attribute" do
    user = User.new(password: "p@ssw0rd")

    expect(user.password_digest.present?).to eq(true)
  end

  describe "authenticate" do
    before do
      @user = User.create!(user_attributes)
    end

    it "returns non-true value if the email does not match" do
      expect(User.authenticate("nomatch", @user.password)).not_to eq(true)
    end

    it "returns non-true value if the password does not match" do
      expect(User.authenticate(@user.email, "nomatch")).not_to eq(true)
    end

    it "returns the user if the email and password match" do
      expect(User.authenticate(@user.email, @user.password)).to eq(@user)
    end
  end

  it "has reviews" do
    user = User.new(user_attributes)
    movie1 = Movie.new(movie_attributes(title: "Iron Man"))
    movie2 = Movie.new(movie_attributes(title: "Superman"))

    review1 = movie1.reviews.new(stars: 5, comment: "Two thumbs up!")
    review1.user = user
    review1.save!

    review2 = movie2.reviews.new(stars: 3, comment: "Cool!")
    review2.user = user
    review2.save!

    expect(user.reviews).to include(review1)
    expect(user.reviews).to include(review2)
  end

  it "has favorite movies" do
    user = User.new(user_attributes)
    movie1 = Movie.new(movie_attributes(title: "Iron Man"))
    movie2 = Movie.new(movie_attributes(title: "Superman"))

    user.favorites.new(movie: movie1)
    user.favorites.new(movie: movie2)

    expect(user.favorite_movies).to include(movie1)
    expect(user.favorite_movies).to include(movie2)
  end
end
