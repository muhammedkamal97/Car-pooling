class Location < ApplicationRecord
  #attr_accessor :from_lat, :from_long, :to_lat, :to_long, :fromAddress, :toAddress
  geocoded_by :fromAddress, :latitude  => :from_lat, :longitude => :from_long
  belongs_to :user
  before_save :geocode_endpoints

  private

  def geocode_endpoints
    if fromAddress_changed?
      geocoded = Geocoder.search(fromAddress).first
      if geocoded
        self.from_lat = geocoded.latitude
        self.from_long = geocoded.longitude
      end
    end
    if toAddress_changed?
      geocoded = Geocoder.search(toAddress).first
      if geocoded
        self.to_lat = geocoded.latitude
        self.to_long = geocoded.longitude
      end
    end
  end
end