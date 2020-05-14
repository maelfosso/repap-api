class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.where(user: @current_user).includes(:hotel)
    json_response(@favorites);
  end

  def create
    @favorite = Favorite.new(hotel_id: params[:hotel])
    @favorite.user = @current_user

    if @favorite.save
      json_response(@favorite, :created)
    else
      json_response(@favorite.errors, :not_acceptable)
    end
  end

  def delete
    json_response(Favorite.delete(params[:id]), :ok)
  end

  private 
  
  def favorite_params
    params.permit(:user, :hotel)
  end
  
end
