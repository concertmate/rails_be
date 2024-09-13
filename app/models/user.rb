class User < ApplicationRecord
  has_many :attendees
  has_many :events
  has_many :user_artists
  has_many :artists, through: :user_artists

  validates :name, presence: true
  validates :email, presence: true

end