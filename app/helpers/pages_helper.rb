module PagesHelper
  ##helper method to recall and fill stored cookie location for index page
  def stored_location
    if cookies[:lat_lon]
      geocode = JSON.parse cookies[:lat_lon]
      location = Geocoder.search(geocode).first
      location.suburb + ", " + location.state
    end
  end
end
