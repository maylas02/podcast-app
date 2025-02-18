class SubscriptionsController < ApplicationController

  def index
    @subscriptions = Subscription.all
  end

  def create
    show_id = params[:show_id]
    show_name = params[:show_name]

    @subscription = current_user.subscriptions.find_or_initialize_by(show_id: show_id)
    @subscription.show_name = show_name

    if @subscription.save
      flash[:notice] = "Subscribed to #{show_name}!"
    else
      flash[:alert] = "Subscription failed."
    end
    redirect_back fallback_location: root_path
  end
  
  def destroy
    subscription = current_user.subscriptions.find(params[:id])
    if subscription.destroy
      flash[:notice] = "Unsubscribed successfully from #{subscription.show_name}."
    else
      flash[:alert] = "Failed to unsubscribe."
    end
    redirect_back(fallback_location: subscriptions_path)
  end
end
