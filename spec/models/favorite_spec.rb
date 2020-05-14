require 'rails_helper'

RSpec.describe Favorite, type: :model do

  it { should belong_to(:hotel) }
  it { should belong_to(:user) }
  
end