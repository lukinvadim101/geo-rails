# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :find_location, only: %i[show update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  def index
    @private_locations = Location.all.where(users: current_user)
    render json: @private_locations
  end

  def show
    if @location.empty?
      render json: { 'message': 'no location found' }
    else
      render json: { location: @location }
    end
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location, status: :ok
    else
      render error: { error: 'Unable to create location.' }, status: :ok
    end
  end

  def update
    if @location
      @location.update(location_params)
      render json: { message: 'location successfully update.' }, status: :ok
    else
      render json: { error: 'Unable to update location.' }, status: 400
    end
  end

  def destroy
    if @location
      @location.destroy
      render json: { message: 'location successfully deleted.' }, status: :ok
    else
      render json: { error: 'Unable to delete location. ' }, status: 400
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :latitude, :longitude, :user_id, :is_private)
  end

  def find_location
    @location = Location.where(id: params[:id], users: current_user)
  end

  def handle_record_not_found
    render json: { 'message': 'no location found' }
  end
end
