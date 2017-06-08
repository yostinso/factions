class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user
  after_action :maintain_session

  private
  def json_redirect_to(path)
    render json: { redirectTo: path }
  end

  def maintain_session
    session[:login_expires_at] = Time.now if session[:user_id]
  end

  def log_user_in(user)
    session[:user_id] = user.id
    session[:login_expires_at] = Time.now
  end

  def find_user
    active = session[:login_expires_at] && session[:login_expires_at] < Time.now
    @user = active && session[:user_id] && User.find_by(id: session[:user_id])
  end

  def requires_user
    redirect_to login_login_path unless @user
  end
end
