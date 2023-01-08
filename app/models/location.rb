# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :user
  validates :name, length: { minimum: 2 }
  # validates :is_private, inclusion: [true, false]

  validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }


  validates_presence_of :name, :latitude, :longitude, :user_id, :is_private
end
