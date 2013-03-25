class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
    @microposts = @user.microposts.paginate(page: params[:page])
    @course = Course.new
  end

  def new
    @user = User.new
  end
  
  def activate
    sign_out
    @user = User.find(:first, :conditions => {:activation_token => params[:activation_token]}) unless params[:activation_token].blank?
    case
      when (!params[:activation_token].blank?) && @user && !@user.activated?
        @user.activate!
        sign_in @user
        flash[:success] = "Account Activated."
        redirect_to @user
      when params[:activation_token].blank?
        flash[:error] = "The activation code was missing. Please follow the URL from your email."
        redirect_back_or('/')
      else
        flash[:error] = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
        redirect_back_or('/')
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Thank you for signing up! Please check your email for activation link."
      UserMailer.activation_email(@user).deliver
      redirect_to signin_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end