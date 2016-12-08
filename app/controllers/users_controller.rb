class UsersController < ApplicationController
  def new
    @user ||= User.new
  end

def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      render :new
    end
  end

def email
  UserMailer.welcome_email.deliver_now
  render nothing: true
end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
