class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def newpw
    user = User.find_by_email(params[:email])
    if user
      newpw = rand(36**7).to_s(36)
      user.password = newpw
      user.password_confirmation = newpw
      user.save!

      UserMailer.new_pw(newpw, user).deliver
      flash[:success] = "Check your mails for your new password"
      redirect_to '/'
    else
      flash[:error] = "Cant find email"
      redirect_to '/pwlost'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Ideadb"
      sign_in @user
      redirect_to root_path
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

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
