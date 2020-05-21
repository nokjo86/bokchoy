class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:set_location]
  def index
  end

  ## Function to store user location to cookie
  def set_location
    rawdata = Geocoder.search("#{params[:address]}")
    if rawdata == []
      cookies.delete :lat_lon
      flash[:alert] = "Oops. I couldn't recognise this address. Please check."
    else
      rawdata = rawdata.first.coordinates
      cookies[:lat_lon] = JSON.generate(rawdata)
    end
    redirect_to listings_url
  end

  def remove_location
    cookies.delete :lat_lon
    redirect_to request.referer
end
end
