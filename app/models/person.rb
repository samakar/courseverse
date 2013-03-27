class Person < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :role
  has_many :schedules
 
  validates :lastname,  presence: true, length: { minimum: 2, maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :role, presence: true, 
    :numericality => { greater_than: 0, less_than_or_equal_to: 4 }
  # validates :email ...
end
