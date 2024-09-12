require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:venue_name) }
    it { should validate_presence_of(:date_time) }
    it { should validate_presence_of(:artist) }
    it { should validate_presence_of(:location) }
  end

  describe 'associations' do
    it { should have_many(:attendees) }
    it { should have_many(:users).through(:attendees) }
  end
end