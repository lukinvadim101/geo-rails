# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :find_location, only: %i[show update destroy]

  def index
    @private_locations = Location.all.where(users: current_user)
    json_response @private_locations
  end

  def show
    json_response @location
  end

  def create
    @location = Location.new(location_params)
    json_response @location
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

  def find_location
    @location = Location.find(params[:id])
  end
end
