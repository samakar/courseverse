module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
  	if user.nil?
    	gravatar_id = Digest::MD5::hexdigest('asamakar1@babson.edu')
  		user_name = 'Guest'
    else
    	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  		user_name = user.name
    end
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user_name, class: "gravatar")
  end
  
  def current_user_admin?
  	!current_user.nil? && current_user.admin?
  end
end
