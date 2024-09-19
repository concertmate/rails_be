class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees

  validates :venue_name, presence: true
  validates :date_time, presence: true
  validates :artist, presence: true
  validates :location, presence: true
end