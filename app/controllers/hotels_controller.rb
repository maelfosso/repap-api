class HotelsController < ApplicationController

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = @current_user
    if @hotel.save
      json_response(@hotel, :created)
    else
      json_response(@hotel.errors, :not_acceptable)
    end
  end

  def hotel_params
    params.permit(:name, :phone, :price, :address, :infos, :latlng)
  end

end
