module ListingsHelper
  def item_location(listing)
    geocode = Profile.find(listing.profile_id).to_coordinates
    location = Geocoder.search(geocode).first
    location.suburb + ", " + location.state
  end

  def img_for(listing)
    if listing.image.present?
      listing.image
    else
      'default.jpeg'
    end
  end
end
