class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:set_location]
  def index
  end
  
  ## Function to store user location to cookie
  def set_location
    cookies[:lat_lon] = JSON.generate(Geocoder.search("#{params[:address]}").first.coordinates)
    redirect_to listings_url
  end

    def remove_location
    cookies[:lat_lon] = nil
    redirect_to listings_url
  end
  
end
