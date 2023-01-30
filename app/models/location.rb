# frozen_string_literal: true

class Location < ApplicationRecord
  scope :by_user, lambda { |user|
    where(users: user) unless user.admin?
  }

  belongs_to :user
  validates :name, length: { minimum: 2 }, allow_blank: false
  validates :is_private, inclusion: [true, false], allow_blank: false

  validates :latitude,
            numericality: {
              greater_than_or_equal_to: -90,
              less_than_or_equal_to: 90
            }
  validates :longitude,
            numericality: {
              greater_than_or_equal_to: -180,
              less_than_or_equal_to: 180
            }

  validates :name, :latitude, :longitude, :user_id, :is_private, presence: true
end
