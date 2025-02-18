class ShowsController < ApplicationController
    before_action :set_show, only: [:show]
  
  def show
    @reviews = @show.reviews.includes(:user)
  end

  def search
    @shows = RSpotify::Show.search(params[:query]) 
  end
  
  private
  
  def set_show
    @show = Show.find(params[:id])
  end
end
