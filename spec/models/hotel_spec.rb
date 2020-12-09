require 'rails_helper'

RSpec.describe Hotel, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:latlng) }

  it { should have_many(:favorites) }
  it { should belong_to(:user) }
end
