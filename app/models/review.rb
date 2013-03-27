class Review < ActiveRecord::Base
  attr_accessible :user_id, :rating
  belongs_to :user
  belongs_to :schedule
  has_many :verses, dependent: :destroy

  validates :schedule_id, presence: true
  validates :user_id, presence: true
  validates :rating, presence: true, 
    :numericality => { greater_than: 0, less_than_or_equal_to: 5 }
  validates_uniqueness_of :user_id, :scope => [:schedule_id] 

  default_scope order: 'reviews.created_at DESC'

end
