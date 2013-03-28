class UserMailer < ActionMailer::Base
  default :from => "CourseVerse <admin@courseverse.com>"
 
  def activation_email(user)
    @user = user
    #site_url="localhost:3000"
    site_url="https://courseverse.herokuapp.com"
    @url  = "#{site_url}/users/#{user.activation_token}/activate"
    mail(:to => user.email, :subject => "Welcome to CourseVerse")
  end
end