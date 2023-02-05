# frozen_string_literal: true

class Api::LocationsController < ApiController
  load_and_authorize_resource

  # GET /locations
  def index
    @locations = Location.by_user(current_user)
    render json: @locations
  end

  # GET  /location/:id
  def show
    @location = Location.find(params[:id])
    render json: @location
  end

  # GET  /api/checkin
  def checkin
    get_coordinates(request)
    @location = set_user_location

    @location.save
    render json: @location
  end

  # POST  api/locations
  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location
    else
      render json: { error: 'Unable to create Location.' }, status: :bad_request
    end
  end

  def update
    if @location
      @location.update(location_params)
      render json: { message: 'location successfully update.' }, status: :ok
    else
      render json: { error: 'Unable to update Location.' }, status: :bad_request
    end
  end

  def destroy
    if @location
      @location.destroy
      render json: { message: 'location successfully deleted.' }, status: :ok
    else
      render json: { error: 'Unable to delete Location. ' }, status: :bad_request
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
