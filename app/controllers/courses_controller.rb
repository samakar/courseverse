class CoursesController < ApplicationController
  autocomplete :course, :title
  before_filter :signed_in_user
  
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(title: params[:title].upcase)
    if @course.save
      flash[:success] = "Course created!"
      redirect_to root_url
    else
      flash[:error] = "Course not created!"
      #@feed_items = []
      #render 'static_pages/home'
      redirect_to root_url
    end
  end

  def show
    @user = current_user
    @course = Course.find(params[:id])
    @reviews = @course.reviews.paginate(page: params[:page])
    @vote = Vote.new
    @top_reviewer = @course.top_reviewer
  end

  def destroy
    @course.destroy
    redirect_to root_url
  end
 
end
