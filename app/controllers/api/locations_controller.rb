# frozen_string_literal: true

module Api
  class LocationsController < ApiController
    load_and_authorize_resource

    # GET /locations
    def index
      @locations = Location.by_user(current_user)
      json_response @locations
    end

    # GET  /location/:id
    def show
      @location = Location.find(params[:id])
      json_response @location
    end

    # GET  /api/checkin
    def checkin
      get_coordinates(request)
      @location = set_user_location

      if @location.save
        json_response @location
      else
        json_response error: 'Unable to save current location.', status: :bad_request
      end
    end

    # POST  api/locations
    def create
      @location = Location.new(location_params)
      if @location.save
        json_response @location
      else
        json_response error: 'Unable to create Location.', status: :bad_request
      end
    end

    def update
      if @location
        @location.update(location_params)
        json_response message: 'location successfully update.'
      else
        json_response error: 'Unable to update Location.', status: :bad_request
      end
    end

    def destroy
      if @location
        @location.destroy
        json_response message: 'location successfully deleted.'
      else
        json_response error: 'Unable to delete Location.', status: :bad_request
      end
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
end
