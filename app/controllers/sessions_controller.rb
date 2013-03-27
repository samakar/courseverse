class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)

    error_message = catch (:error_message) {
      if user.nil?
        throw :error_message, "Invalid email."
      elsif !user.authenticate(params[:session][:password])
        throw :error_message, "Invalid password."
      elsif !user.activated?
        UserMailer.activation_email(user).deliver
        throw :error_message, 'Your account is not activated. Please check your email for activation link.'
      end           
    }

    if error_message.nil?
      flash[:success] = "Welcome back!"
      sign_in user
      redirect_back_or user
    else
      flash[:error] = error_message
      render 'new'
    end

  end

  def destroy
    sign_out
    redirect_to root_url
  end
end