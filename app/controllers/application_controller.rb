class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method "current_user=", "current_user", "active_class", "own_event"

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def active_class(p, ctl, act)
    if p[:controller] == ctl && p[:action] == act
      'class=active'
    else
      ''
    end
  end

  def own_event(evt)
    user = current_user
    if user && user.id == evt.user_id
      true
    else
      false
    end 
  end

end
