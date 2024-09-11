class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events

  validates :name, presence: true
  validates :email, presence: true
  
end