require 'spec_helper'

describe Review do
  it { should validate_presence_of(:comment) }
  it { should validate_length_of(:comment).is_at_least(4) }
  it { should validate_inclusion_of(:stars).in_array(Review::STARS) }

  it { should belong_to(:movie) }
  it { should belong_to(:user) }

  it "with example attributes is valid" do
    review = Review.new(review_attributes)

    expect(review.valid?).to eq(true)
  end
end
