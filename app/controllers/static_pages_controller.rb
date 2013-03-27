class StaticPagesController < ApplicationController

  def home
    @course_count = Course.count
    @courses = Course.paginate(page: params[:page], per_page: 10)
    @course = Course.new
    if signed_in?
      #@micropost  = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end

  
  def landing_page
    render 'landing_page'
  end
end
