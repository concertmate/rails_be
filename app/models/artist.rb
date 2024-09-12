class Artist < ApplicationRecord
  has_many :user_artists
  has_many :users, through: :user_artists

  validates :name, presence: true
  validates :musicbrainz_id, presence: true, uniqueness: true
end