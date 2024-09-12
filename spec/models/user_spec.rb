require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'associations' do
    it { should have_many(:attendees) }
    it { should have_many(:events) }
    it { should have_many(:user_artists) }
    it { should have_many(:artists).through(:user_artists) }
  end
end