class UsersController < ApplicationController
  include SessionsHelper

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
    render :new
  end

  def update
    puts 'abc'
  end

  def new
    @user = User.new
    render layout: "signin_signup"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to home_path
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :title, :first_name, :last_name, :gender, :status)
    end
end
