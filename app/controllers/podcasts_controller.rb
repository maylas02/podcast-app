class PodcastsController < ApplicationController
  require 'i18n_data'
  before_action :authenticate_spotify

  def search
    if params[:search].present?
      @podcast = RSpotify::Episode.search(params[:search])
      respond_to do |format|
        format.html
        format.json { render json: @podcast }
      end
    end
  end

  def show
    @episode = RSpotify::Episode.find(params[:id])
    @feedback = Feedback.new
    @feedbacks = Feedback.where(podcast_id: params[:id])  # To display all feedbacks
  end

  def favorite
    begin
      @episode = RSpotify::Episode.find(params[:episode_id])
      if @episode
        current_user.episodes.create(
          spotify_id: @episode.id,
          name: @episode.name,
          show: @episode.show.name
        )
        flash[:notice] = 'Episode added to favorites!'
        redirect_to podcasts_path
      else
        flash[:alert] = 'Episode not found'
        redirect_to podcasts_path
      end
    rescue RSpotify::Error => e
      flash[:alert] = 'Could not add episode to favorites'
      redirect_to podcasts_path
    end
  end
  
  def unfavorite
    episode = current_user.episodes.find_by(spotify_id: params[:id])
    if episode&.destroy
      flash[:notice] = 'Episode removed from favorites'
    else
      flash[:alert] = 'Could not remove episode from favorites'
    end
    redirect_back(fallback_location: podcasts_path)
  end

  def played
    episode = current_user.episodes.find_by(spotify_id: params[:id])
    if episode.update(played: true)
      flash[:notice] = 'Episode marked as played'
    else
      flash[:alert] = 'Could not update episode status'
    end
    redirect_back(fallback_location: podcasts_path)
  end
  
  def unplayed
    episode = current_user.episodes.find_by(spotify_id: params[:id])
    if episode.update(played: false)
      flash[:notice] = 'Episode marked as unplayed'
    else
      flash[:alert] = 'Could not update episode status'
    end
    redirect_back(fallback_location: podcasts_path)
  end

  def finished
    episode = current_user.episodes.find_by(spotify_id: params[:id])
    if episode.update(finished: true)
      flash[:notice] = 'Episode marked as finished'
    else
      flash[:alert] = 'Could not update episode status'
    end
    redirect_back(fallback_location: podcasts_path)
  end
   
  def unfinished
    episode = current_user.episodes.find_by(spotify_id: params[:id])
    if episode.update(finished: false)
      flash[:notice] = 'Episode marked as unfinished'
    else
      flash[:alert] = 'Could not update episode status'
    end
    redirect_back(fallback_location: podcasts_path)
  end

  private

  def authenticate_spotify
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])
  end
end

