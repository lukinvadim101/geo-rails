# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @locations = Location.all
  end
end
