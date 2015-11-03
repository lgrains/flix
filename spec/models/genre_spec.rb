require 'spec_helper'

RSpec.describe Genre do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it { should have_many(:characterizations).dependent(:destroy) }
  it { should have_many(:movies).through(:characterizations) }
end
