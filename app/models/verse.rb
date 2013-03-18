class Verse < ActiveRecord::Base
  attr_accessible :content, :review_id, :score, :topic_id
  belongs_to :review
  validates :content, presence: true, length: { maximum: 140 }
  validates :topic_id, presence: true
  validates :review_id, presence: true

  default_scope order: 'verses.topic_id'

end
