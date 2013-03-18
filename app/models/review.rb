class Review < ActiveRecord::Base
  attr_accessible :content, :schedule_id, :topic_id
  belongs_to :user
  belongs_to :schedule
  has_many :verses, dependent: :destroy

  validates :schedule_id, presence: true
  validates :user_id, presence: true

  default_scope order: 'reviews.created_at DESC'

end
