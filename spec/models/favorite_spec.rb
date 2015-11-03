require 'spec_helper'

describe Favorite do
  it { should belong_to(:movie) }
  it { should belong_to(:user) }
end
