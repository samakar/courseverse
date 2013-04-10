class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :role, :privacy
  has_secure_password
  has_one :facebook, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :verses, :through => :votes

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { email.downcase! }
  before_save :create_remember_token
  before_create :create_activation_token

  validates :name,  presence: true, length: { maximum: 50 }
  
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.edu$/i          # old /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@babson.edu$/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX , message: "is invalid or not a babson.edu email."},
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if  => :validate_password?
  validates :password_confirmation, presence: true, :if  => :validate_password?
  validates :role, presence: true
  validates :privacy, presence: true

  def validate_password?
    self.password.present? || self.password_confirmation.present?
  end
  
  def activate
    self.activation_token = ''
    self.admin = true if self.email == 'asamakar1@babson.edu'
    self.save
  end
 
  # Returns true if the user has been activated.
  def activated?
    self.activation_token.empty? == true
  end

  def student?
    self.role == 1
  end
  
  def received_likes
    # algorithm ignores the improbable fact that
    # each user may review a course on more than one schedule
    total_likes = 0

    self.reviews.each do |r|
      r.verses.each do |v|
        total_likes += v.likes
      end
    end

    return total_likes
  end 
  
  def friend_list
    if self.friendships.nil?
      []
    else
      self.friendships.pluck(:friend_id)
    end
  end

  def make_name
    email_name = self.email.split("@")[0]
    i = 0
    name = ''
    email_name.each_char do |l|   
      if l =~ /^[0-9]+$/
        break
      else
        case i
        when 0
          name = l.upcase + ". "
        when 1
          name += l.upcase
        else
          name += l
        end
        i +=1
      end
    end
    self.name = name
  end

  # Unused methods in app
  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_activation_token
      self.activation_token = SecureRandom.urlsafe_base64
    end

end
