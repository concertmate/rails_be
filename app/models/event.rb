class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events

  validates :venue_name, presence: true
  validates :date_time, presence: true
  validates :artist, presence: true
  validates :location, presence: true

end