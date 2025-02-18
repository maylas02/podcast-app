class UsersController < ApplicationController
  def favorites
    @favorite_episodes = current_user.episodes
  end

  def subscriptions
    @subscriptions = current_user.subscriptions.includes(:user)  # Get all subscriptions for the current user
  end
end 