require 'geocoder'

class Location < ActiveRecord::Base
    def getLocation(user, orgs)
        user_coords = Geocoder.coordinates("#{user.street} #{user.zip}")
        org_coords = Geocoder.coordinates("#{org.street} #{org.zip}")
        distance = Geocoder::Calculations.distance_between(user_coords, org_coords)
    end
end