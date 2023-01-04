# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @locations = Location.all

    # return unless Rails.env.production?

    @country = request.location.country_code
    @city = request.location.city
  end
end
