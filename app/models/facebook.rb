class Facebook < ActiveRecord::Base
  self.primary_key = "uid"
  attr_accessible :first_name, :name, :pic_square, :uid, :user_id, :username, :sex
  belongs_to :user
  validates :name,  presence: true
  validates :uid,  presence: true
  validates :user_id,  presence: true
  validates :username,  presence: true

  def self.get_oauth
    if Rails.env.development?
      #FB_test
      app_id= '412787918757685'
      app_secret= '5514773926aaf0f3d42784ef384e38eb'
      site_url = 'http://localhost:3000'
    else
      #CourseVerse
      app_id= '179887045493563'
      app_secret= '64c99d36f972d01f2005be4349da8789'
      site_url = 'https://courseverse.heroku.com'
    end
    return Koala::Facebook::OAuth.new(app_id, app_secret, site_url + '/facebooks/create')
  end

  def self.oauth_current_user(access_token, current_user)
    @graph = Koala::Facebook::API.new(access_token)
    me = @graph.fql_query("select uid, username, first_name, name, sex, pic_square from user where uid = me()")
    friends = @graph.get_connections("me", "friends")
    
    me = me[0]
    facebook = self.new(user_id: current_user.id, uid: me['uid'], username: me['username'], 
      first_name: me['first_name'], name: me['name'], sex: me['sex'], pic_square: me['pic_square'])
    facebook.save!

    facebook_users = self.select("uid, user_id")
    #logger.debug "HELLO"
    #qq=0
    #facebook_users.each do |f|
    #  logger.debug "facebook_users:  #{f.inspect} || #{f[:uid]}"
    #  qq= f[:uid]
    #end
      #facebook_user = facebook_users.select {|user| user[:uid] == qq }
      #logger.debug "1qq friends:  #{facebook_user.blank?}"
      #logger.debug "2qq friends:  #{facebook_user.inspect}"
      #logger.debug "3qq friends:  #{facebook_user[0]}"
      #logger.debug "5qq friends:  #{facebook_user[0][:user_id]}"
      #logger.debug "6qq friends:  #{facebook_user[0][:uid]}"

    friends.each do |f|
    	facebook_user = facebook_users.select {|user| user[:uid].to_s == f['id'] }
      #logger.debug "friends:  #{f.inspect} facebook_user #{facebook_user.inspect}"
    	if not facebook_user.blank?
      #logger.debug "facebook_user Friendship:  #{facebook_user.inspect}"
      
    		Friendship.create(user_id: current_user.id, friend_id: facebook_user[0][:user_id])
    		Friendship.create(user_id: facebook_user[0][:user_id], friend_id: current_user.id)
      end
    end
  end

end
