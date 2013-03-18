class Schedule < ActiveRecord::Base
  attr_accessible :semester, :year
  belongs_to :course
  has_many :reviews, dependent: :destroy

  validates :course_id, presence: true
  validates :semester, presence: true, 
    :numericality => { greater_than: 0, less_than_or_equal_to: 4 }
  validates :year, presence: true, 
    :numericality => { greater_than: 2010, less_than_or_equal_to: (Date.today.year) + 1 }
end
