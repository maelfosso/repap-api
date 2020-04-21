class HotelsController < ApplicationController

  def create
    @hotel = Hotel.create!(hotel_params)
    json_params(@hotel, :created)
  end

  def hotel_params
    params.permit(:name, :phone, :address, :infos, :latlng)
  end

end
