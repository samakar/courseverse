class ReviewsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def destroy
    @review.destroy
    redirect_to current_user
  end

  private

    def correct_user
      @review = current_user.reviews.find_by_id(params[:id])
      redirect_to root_url if @review.nil?
    end
end