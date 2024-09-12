class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  has_many :user_artists, dependent: :destroy
  has_many :artists, through: :user_artists

  validates :name, presence: true
  validates :email, presence: true
  
end