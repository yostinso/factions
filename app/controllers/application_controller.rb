class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :maintain_session

  private
  def maintain_session
    session[:login_expires_at] = Time.now
  end

  def requires_user
    expired = session[:login_expires_at] && session[:login_expires_at] < Time.now
    @user = session[:user_id] && User.find_by(id: session[:user_id])
    redirect_to login_login_path if expired || @user.nil?
  end
end
