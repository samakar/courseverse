class Vote < ActiveRecord::Base
  attr_accessible :verse_id, :user_id
  belongs_to :user
  belongs_to :verse
  validates :verse_id, presence: true
  validates :user_id, presence: true
  # each user can have a single vote (no vote history tracking)
  validates_uniqueness_of :verse_id, :scope => [:user_id] 
end
