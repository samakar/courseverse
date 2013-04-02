class Course < ActiveRecord::Base
  attr_accessible :code, :title, :schedules_attributes
  #belongs_to :college
  has_many :schedules, dependent: :destroy
  has_many :reviews, through: :schedules
  before_validation :default_values

  validates :college_id, presence: true
  validates :title, presence: true, length: { maximum: 50, minimum: 3 },
                    uniqueness: { case_sensitive: false }
  #validates :code, uniqueness: { case_sensitive: false }
  #validates_associated :schedules
  accepts_nested_attributes_for :schedules

  def reviews_count
  	n = 0 
  	self.schedules.all.each { |s| n += s.reviews.count  }
    return n
  end	

  def top_reviewer
    # algorithm ignores the improbable fact that
    # each user may review a course on more than one schedule
    max_likes = 0
    max_user = nil

    self.reviews.each do |r|
      total_likes = 0
      r.verses.each do |v|
        total_likes += v.likes
      end
      if total_likes > max_likes 
        max_likes = total_likes
        max_user = r.user
      end
    end
    if max_likes==0
      return {likes: 0, user: nil}
    else
      return {likes: max_likes, user: max_user}
    end
  end 

  private
    def default_values
      self.college_id ||= 1
    end

end
