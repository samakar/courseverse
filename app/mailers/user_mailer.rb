class UserMailer < ActionMailer::Base
  default :from => "CourseVerse <admin@courseverse.com>"
 
  def activation_email(user)
    if Rails.env.development?
      site_url = 'http://localhost:3000'
    else
      site_url = "https://courseverse.herokuapp.com"
    end
    @user = user
    @url  = "#{site_url}/users/#{user.activation_token}/activate"
    mail(:to => user.email, :subject => "Welcome to CourseVerse")
  end
end