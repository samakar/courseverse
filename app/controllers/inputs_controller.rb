class InputsController < ApplicationController
  before_filter :signed_in_user
  
  def new
    @course = Course.new
  end

  def create
    @course = self.make_course
    @schedule = self.make_schedule unless @course.is_a? String
    @review = self.make_review unless @schedule.is_a? String
    self.make_verse(params[:content_1], 1) unless @review.is_a? String 
    self.make_verse(params[:content_2], 2) unless @review.is_a? String 
    self.make_verse(params[:content_3], 3) unless @review.is_a? String 
    self.make_verse(params[:content_4], 4) unless @review.is_a? String 
    
    if !self.errors
      flash[:success] = "Thank you! Your review is recieved."
    else
      flash[:error] = self.errors
    end

    redirect_to root_url
  end

  def destroy
    @course.destroy
    redirect_to root_url
  end
 
  def make_course
    course = Course.new(title: params[:title].upcase)
    if course.save
      return course
    else
      existing_course = Course.where('lower(title) = ?', params[:title].downcase ).first 
      if existing_course.nil?
        return  "Course title has invalid characters."
      else
        return existing_course
      end
    end
  end

  def make_schedule
    schedule = @course.schedules.build(year: params[:year], semester: params[:semester])
    if schedule.save
      return schedule
    else
      existing_schedule = Schedule.where("course_id = ? AND semester = ? AND year = ?", 
        @course.id, params[:semester], params[:year]).first
      if existing_schedule.nil?
        return  "Schedule is invalid."
      else
        return existing_schedule
      end
    end
  end

  def make_review
    review = @schedule.reviews.build(user_id: current_user.id )
    if review.save
      return review
    else
      existing_review = Review.where("schedule_id = ? AND user_id = ? ", 
        @schedule.id, current_user.id ).first
      if existing_review.nil?
        return  "Review info is invalid."
      else
        return "You have already made a review."
      end
    end
  end

  def make_verse(content, topic_id)
    if !content.blank?
      verse = @review.verses.build(content: content, topic_id: topic_id)
      if verse.save
        return verse
      else
    c=1/0
        @review.destroy
        existing_verse = Verse.where("review_id = ? AND topic_id = ? ", 
          @review.id, topic_id )
        if existing_review.nil?
          @review =  "Review  is longer than 140 characters or invalid : " + content
        else
          @review = "You have already made a review."
        end
      end
    end
  end

  def errors
    error_message = false
    error_message = @course if @course.is_a? String 
    error_message = @schedule if @schedule.is_a? String
    error_message = @review if @review.is_a? String
    
    if !error_message and @review.verses.count == 0
      @review.destroy
      error_message = "Review is blank."
    end  

    return error_message
  end

end