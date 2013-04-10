class Verse < ActiveRecord::Base
  attr_accessible :content, :review_id, :score, :topic_id
  belongs_to :review
  has_many :votes, dependent: :destroy
  has_many :users, :through => :votes
  validates :content, presence: true, length: { maximum: 300, minimum: 3 }
  validates :topic_id, presence: true
  validates :review_id, presence: true
  validates_uniqueness_of :topic_id, :scope => [:review_id] 

  default_scope order: 'verses.topic_id'

  def likes
  	self.users.count
  end
end
