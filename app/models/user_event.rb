require "rails_helper"

class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :host, inclusion: { in: [true, false] }
  validates :user_id, presence: true
  validates :event_id, presence: true
end