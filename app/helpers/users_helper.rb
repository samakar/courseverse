module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
  	if user.nil?
    	gravatar_url = 'gravatar.jpg'
  		user_name = 'Guest'
    else
      user_name = display_name(user)
      gravatar_url = display_image(user)
    end
    image_tag(gravatar_url, alt: user_name, size: "50x50", class: "gravatar")
  end
  
  def current_user_admin?
  	!current_user.nil? && current_user.admin?
  end


  def display_name(user)
    if user == current_user
      user.facebook.nil? ? user.name : user.facebook.name
    else
      case user.privacy
        when 9
          "anonymous user"
        when 6
          current_user_friends?(user) ? 'your friend' : 'anonymous user'
        when 3
          current_user_friends?(user) ? user.facebook.name : 'anonymous user'
        else
          user.facebook.nil? ? user.name : user.facebook.name
      end
    end
  end

  def display_image(user)
    if user == current_user
      user.facebook.nil? ? 'gravatar.jpg' : user.facebook.pic_square
    else
      case user.privacy
        when 9
          'gravatar.jpg'
        when 6
          'gravatar.jpg'
        when 3
          current_user_friends?(user) ? user.facebook.pic_square : 'gravatar.jpg'
        else
          user.facebook.nil? ? 'gravatar.jpg' : user.facebook.pic_square
      end
    end
  end

  def facebook_link(user)
    fb = 'https://www.facebook.com/'
    if user == current_user
      user.facebook.nil? ? '' : (fb + user.facebook.username)
    else
      case user.privacy
        when 9
          ''
        when 6
          ''
        when 3
          current_user_friends?(user) ? (fb + user.facebook.username) : ''
        else
          user.facebook.nil? ? '' : (fb + user.facebook.username)
      end
    end
  end

end