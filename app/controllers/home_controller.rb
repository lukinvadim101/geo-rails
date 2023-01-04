# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @private_locations = Location.all.where(users: current_user)
    @public_locations = Location.all

    # return unless Rails.env.production?

    @country = request.location.country_code
    @city = request.location.city
  end
end
