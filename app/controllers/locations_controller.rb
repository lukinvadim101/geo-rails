# frozen_string_literal: true

class LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    @locations = Location.all.where(users: current_user)
    json_response @locations
  end

  def save
    coordinates = GeocoderServices::GetLocationFromIp.new(request).call

    location = Location.new(
      name: coordinates[:name],
      longitude: coordinates[:longitude],
      latitude: coordinates[:latitude],
      is_private: true,
      user_id: current_user.id
    )

    location.save
    json_response location
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
end
