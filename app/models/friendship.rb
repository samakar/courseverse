class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id
  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"

  validates :friend_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :friend_id, :scope => [:user_id] 

end