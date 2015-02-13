class PlacesController < ApplicationController
  def index
  end

  def show
    @places = Rails.cache.read(session[:last_search])
    i = @places.find_index {|place| place.id == params[:id]}
    @place = @places[i]
    render :show
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_search] = params[:city]
      render :index
    end
  end
end