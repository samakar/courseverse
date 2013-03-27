class InputsController < ApplicationController
  before_filter :signed_in_user
  
  def new
    @course = Course.new
  end

  def create
    error_message = catch (:error_message) {
      @course = self.make_course
      @professor = self.make_professor
      @schedule = self.make_schedule
      @review = self.make_review
      self.make_verse(params[:content_1], 1)
      self.make_verse(params[:content_2], 2)
      self.make_verse(params[:content_3], 3)
      self.make_verse(params[:content_4], 4)
      self.check_verses 
    }

    if error_message.nil?
      flash[:success] = "Thank you! Your review is recieved."
    else
      flash[:error] = error_message
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
        throw :error_message, "Course title has invalid characters or empty."
      else
        return existing_course
      end
    end
  end

  def make_professor
    professor = Person.new(lastname: params[:professor].capitalize, role: 2)
    if professor.save
      return professor
    else
      existing_professor = Person.where('lower(lastname) = ? AND role=2',
       params[:professor].downcase ).first 
      if existing_professor.nil?
        throw :error_message, "Professor name has invalid characters or empty."
      else
        return existing_professor
      end
    end
  end
  
  def make_schedule
    schedule = @course.schedules.build(year: params[:year], 
      semester: params[:semester], person_id: @professor.id)
    if schedule.save
      return schedule
    else
      existing_schedule = Schedule.where("course_id = ? AND semester = ? AND year = ?", 
        @course.id, params[:semester], params[:year]).first
      if existing_schedule.nil?
        throw :error_message,   "Schedule is invalid."
      else
        return existing_schedule
      end
    end
  end

  def make_review
    review = @schedule.reviews.build(user_id: current_user.id, rating: params[:rating] )
    if review.save
      return review
    else
      existing_review = Review.where("schedule_id = ? AND user_id = ? ", 
        @schedule.id, current_user.id ).first
      if existing_review.nil?
        throw :error_message, "You have not rated the course."
      else
        throw :error_message, "You have already made a review."
      end
    end
  end

  def make_verse(content, topic_id)
    if !content.blank?
      verse = @review.verses.build(content: content, topic_id: topic_id)
      if verse.save
        return verse
      else
        @review.destroy
        existing_verse = Verse.where("review_id = ? AND topic_id = ? ", 
          @review.id, topic_id )
        if existing_review.nil?
          throw :error_message, "Review  is longer than 140 characters or invalid : " + content
        else
          throw :error_message, "You have already made a review."
        end
      end
    end
  end

  def check_verses  
    if @review.verses.count == 0
      @review.destroy
      throw :error_message, "Review is blank."
    end  
  end

end