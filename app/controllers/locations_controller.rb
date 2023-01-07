# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :find_location, only: %i[show update destroy]
  def index
    @private_locations = Location.all.where(users: current_user)
    json_response @private_locations
  end

  def show
    if @location.empty?
      json_response 'message': 'no location found'
    else
      json_response @location
    end
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
    if @location
      @location.destroy
      json_response message: 'location successfully deleted.'
    else
      json_response error: 'Unable to delete location. ', status: 400
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :latitude, :longitude, :user_id, :is_private)
  end

  def find_location
    @location = Location.where(id: params[:id], users: current_user)
  end
end
