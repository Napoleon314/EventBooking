class StaticPagesController < ApplicationController
  def index
    redirect_to home_path
  end

  def home
  end

  def about
  end
end
