class ReviewsController < ApplicationController
    before_action :authenticate_user!
  before_action :set_show, only: [:create, :index]
  
  def create
    @review = current_user.reviews.build(review_params)
    @review.show = @show
    
    if @review.save
      redirect_to show_path(@show), notice: 'Review was successfully created.'
    else
      redirect_to show_path(@show), alert: @review.errors.full_messages.join(", ")
    end
  end
  
  def index
    @reviews = @show.reviews.includes(:user).order(created_at: :desc)
  end
  
  private
  
  def set_show
    @show = Show.find(params[:show_id])
  end
  
  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
