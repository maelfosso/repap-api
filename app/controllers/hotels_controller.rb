class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[add_photo show]

  def index
    hotels = Hotel.all
    ActiveRecord::Associations::Preloader.new.preload(hotels, :favorites, Favorite.where(user: @current_user))
    json_response hotels
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = @current_user
    if @hotel.save
      json_response(@hotel, :created)
    else
      json_response(@hotel.errors, :not_acceptable)
    end
  end

  def add_photo
    @hotel.photos.attach(params[:files])
    if @hotel.save
      json_response(@hotel, :created)
    else
      json_response(@hotel.errors, :unprocessable_entity)
    end
  end

  def show
    json_response(@hotel)
  end

  private

  def hotel_params
    params.permit(:name, :phone, :price, :address, :infos, :latlng)
  end

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end
end
