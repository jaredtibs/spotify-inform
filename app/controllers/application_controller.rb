class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def login_required
    unless current_user
      store_location
      redirect_to '/'
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

end
