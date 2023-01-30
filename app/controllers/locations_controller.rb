# frozen_string_literal: true

class LocationsController < ApiController
  load_and_authorize_resource
  def index
    @locations = Location.by_user(current_user)
    json_response @locations
  end

  def save
    get_coordinates(request)
    location = set_user_location

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
    json_response(message: 'location successfully update.', location: @location)
  end

  def destroy
    @location.destroy
    json_response message: 'location successfully deleted.'
  end

  private

  def get_coordinates(request)
    @coordinates = GeocoderServices::GetLocationFromIp.new(request).call
  end

  def set_user_location
    Location.new(
      name: @coordinates[:name],
      longitude: @coordinates[:longitude],
      latitude: @coordinates[:latitude],
      is_private: true,
      user_id: current_user.id
    )
  end

  def location_params
    params.require(:location).permit(:name, :latitude, :longitude, :user_id, :is_private)
  end
end
