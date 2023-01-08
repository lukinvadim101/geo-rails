# frozen_string_literal: true

class LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    save_user_coordinates if Rails.env.production?

    @locations = Location.all.where(users: current_user)
    json_response @locations
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
      user_id: current_user.id
    )

    return unless current_geo.valid?

    current_geo.save
  end
end
