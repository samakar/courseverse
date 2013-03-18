class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.activated?
      sign_in user
      redirect_back_or user
    elsif !user.activated?
      flash.now[:error] = 'Your account is not activated. Please check your email for activation link.'
      UserMailer.activation_email(user).deliver
      render 'new'
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end