class Schedule < ActiveRecord::Base
  attr_accessible :semester, :year, :person_id
  belongs_to :course
  belongs_to :person
  has_many :reviews, dependent: :destroy

  validates :course_id, presence: true
  validates :person_id, presence: true
  validates :semester, presence: true, 
    :numericality => { greater_than: 0, less_than_or_equal_to: 4 }
  validates :year, presence: true, 
    :numericality => { greater_than: 2010, less_than_or_equal_to: (Date.today.year) + 1 }
  # composite key  
  validates_uniqueness_of :course_id, :scope => [:semester, :year, :person_id] 

  def professor
    if not self.person.nil?
       'Prof. ' + self.person.lastname.capitalize
    end
  end
end
