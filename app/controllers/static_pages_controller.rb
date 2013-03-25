class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @course_count = Course.count
      @courses = Course.paginate(page: params[:page])
      @micropost  = current_user.microposts.build
      @course = Course.new
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
