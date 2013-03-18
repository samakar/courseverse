class Course < ActiveRecord::Base
  attr_accessible :code, :college_id, :title
  #belongs_to :college
  has_many :schedules, dependent: :destroy

  validates :college_id, presence: true
  validates :title, presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :code, uniqueness: { case_sensitive: false }

  def reviews_count
  	count = 0 
  	self.schedules.each { |s| count += s.reviews.count}
  	return count
  end	
end
