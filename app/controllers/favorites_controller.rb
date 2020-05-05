class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      json_response(@favorite, :created)
    else
      json_response(@favorite.errors, :not_acceptable)
    end
  end

  def delete
    json_response(Favorite.delete(params[:id]), :ok)
  end

  def favorite_params
    params.permit(:user, :hotel)
  end
  
end
