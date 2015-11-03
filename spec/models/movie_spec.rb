require 'spec_helper'

RSpec.describe Movie do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_least(25) }
  it { should validate_presence_of(:released_on) }
  it { should validate_presence_of(:duration) }
  it { should validate_numericality_of(:total_gross) }
  it { should validate_inclusion_of(:rating).in_array(Movie::RATINGS) }

  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:critics) }
  it { should have_many(:favorites) }
  it { should have_many(:fans).through(:favorites) }
  it { should have_many(:characterizations).dependent(:destroy) }
  it { should have_many(:genres).through(:characterizations) }

  it "is a flop if the total gross is less than $50M" do
    movie = Movie.new(total_gross: 40000000)

    expect(movie.flop?).to eq(true)
  end

  it "is not a flop if the total gross is greater than $50M" do
    movie = Movie.new(total_gross: 60000000)

    expect(movie.flop?).to eq(false)
  end

  it "is released when the released on date is in the past" do
    movie = Movie.create(movie_attributes(released_on: 3.months.ago))

    expect(Movie.released).to include(movie)
  end

  it "is not released when the released on date is in the future" do
    movie = Movie.create(movie_attributes(released_on: 3.months.from_now))

    expect(Movie.released).not_to include(movie)
  end

  it "accepts a $0 total gross" do
    movie = Movie.new(total_gross: 0.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "accepts a positive total gross" do
    movie = Movie.new(total_gross: 10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(false)
  end

  it "rejects a negative total gross" do
    movie = Movie.new(total_gross: -10000000.00)

    movie.valid?

    expect(movie.errors[:total_gross].any?).to eq(true)
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png movie.png movie.jpg movie.gif MOVIE.GIF]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[movie .jpg .png .gif movie.pdf movie.doc]
    file_names.each do |file_name|
      movie = Movie.new(image_file_name: file_name)
      movie.valid?
      expect(movie.errors[:image_file_name].any?).to eq(true)
    end
  end

  it "is valid with example attributes" do
    movie = Movie.new(movie_attributes)

    expect(movie.valid?).to eq(true)
  end

  it "returns released movies ordered with the most recently-released movie first" do
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago))
    movie2 = Movie.create(movie_attributes(released_on: 2.months.ago))
    movie3 = Movie.create(movie_attributes(released_on: 1.months.ago))

    expect(Movie.released).to eq([movie3, movie2, movie1])
  end

  it "calculates the average number of review stars" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes(stars: 1))
    movie.reviews.create(review_attributes(stars: 3))
    movie.reviews.create(review_attributes(stars: 5))

    expect(movie.average_stars).to eq(3)
  end

  it "returns the two most recent reviews" do
    movie = Movie.create(movie_attributes)
    review1 = movie.reviews.create(review_attributes(created_at: Time.now))
    review2 = movie.reviews.create(review_attributes(created_at: Time.now - 3.days))
    review3 = movie.reviews.create(review_attributes(created_at: Time.now - 6.days))

    expect(movie.recent_reviews).to include(review1)
    expect(movie.recent_reviews).to include(review2)
    expect(movie.recent_reviews).to_not include(review3)

  end
end
