module ListingsHelper
  def item_location(listing)
    geocode = Profile.find(listing.profile_id).to_coordinates
    location = Geocoder.search(geocode).first
    location.suburb + ", " + location.state
  end
end
