# frozen_string_literal: true

module GeocoderServices
  class GetLocationFromIp
    def initialize(request)
      @ip = check_ip(request)
    end

    def call
      location = Geocoder.search(@ip).first
      coordinates = get_latitude_longitude(location)
      coordinate_name = get_location_name(location)
      coordinates.merge(coordinate_name)
    end

    private

    def check_ip(request)
      if Rails.env.production?
        request.remote_ip
      else
        Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      end
    end

    def get_latitude_longitude(location)
      coordinates_array = location.data['loc'].split(',')
      {
        latitude: coordinates_array.first.to_f,
        longitude: coordinates_array.last.to_f
      }
    end

    def get_location_name(location)
      {
        name: location.data['city']
      }
    end
  end
end
