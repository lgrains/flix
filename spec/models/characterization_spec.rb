require 'spec_helper'

describe Characterization do
  it { should belong_to(:movie) }
  it { should belong_to(:genre) }
end
