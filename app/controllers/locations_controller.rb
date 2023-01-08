# frozen_string_literal: true

class LocationsController < ApplicationController
  load_and_authorize_resource

  def index
    @private_locations = Location.all.where(users: current_user)
    json_response @private_locations
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
