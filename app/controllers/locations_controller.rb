# frozen_string_literal: true

class LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    @locations = Location.all.where(users: current_user)
    json_response @locations
  end

  def autosave
    save_user_coordinates if Rails.env.production?
    json_response 'coordinates': {
      longitude: request.location.longitude || 'hmm',
      latitude: request.location.latitude   || 'hmm'
    }
  end

  def show
    json_response @location
  end

  def create
    @location = Location.create!(location_params)
    json_response(@location, :created)
  end

  def update
    @location.update(location_params)
    json_response message: 'location successfully update.'
  end

  def destroy
    @location.destroy
    json_response message: 'location successfully deleted.'
  end

  private

  def location_params
    params.require(:location).permit(:name, :latitude, :longitude, :user_id, :is_private)
  end

  def save_user_coordinates
    current_geo = Location.new(
      name: 'autosave',
      longitude: request.location.longitude,
      latitude: request.location.latitude,
      user_id: current_user.id,
      is_private: true
    )

    return unless current_geo.valid?

    current_geo.save
    current_geo
  end
end
