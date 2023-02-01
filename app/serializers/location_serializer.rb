# frozen_string_literal: true

class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :user_id, :created_at
end
