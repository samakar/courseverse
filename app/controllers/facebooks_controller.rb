class FacebooksController < ApplicationController
  before_filter :signed_in_user

  def oauth
    session[:oauth] = Facebook::get_oauth
    redirect_to session[:oauth].url_for_oauth_code
  end

  def create
	if params[:code]
	  begin
      #access_token = session[:oauth].get_access_token(params[:code])    
	    Facebook::oauth_current_user(current_user)
		flash[:success] = "Facebook profile created!"
	  rescue Exception=>ex
	    flash[:error] = "Facebook profile not created:" + ex.message
	  end
	else
	    flash[:error] = "Facebook profile not created: no reply from Facebook"
	end

    redirect_to current_user
  end

  def destroy
    @facebook.destroy
    redirect_to current_user
  end

end
