class SessionsController < ApplicationController
  include SessionsHelper

  def new
    render layout: "signin_signup"
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])

    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      render :new
    else
      sign_in user
      redirect_to home_path
    end
  end

  def destroy
    sign_out
    redirect_to home_path
  end
end
