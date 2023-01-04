# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :user
  validates :name,        presence: true, length: { minimum: 2 }
  validates :latitude,    presence: true, numericality: true
  validates :longitude,   presence: true, numericality: true
  validates :user_id,     presence: true, numericality: true
  validates :is_private,  presence: true, boolean: true
end
