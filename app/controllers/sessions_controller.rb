class SessionsController < ApplicationController
  skip_before_action :login_required
  layout 'sign_in'

  def new
    redirect_to tracks_path if current_user
  end

  def create
    spotify_auth_hash = request.env["omniauth.auth"]
    if user = User.from_spotify_auth(google_auth)
      session[:user_id] = user.id
      redirect_back_or tracks_path
    else
      alert_message = "Sorry, we were unable to sign you in with that Spotify account."
      redirect_to root_path, alert: alert_message
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
