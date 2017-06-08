class LoginsController < ApplicationController
  before_action :find_user, only: [ :index ]
  def index
    if @user
      redirect_to faction_path
    else
      render component: 'pages/LoginPage', props: { csrfToken: form_authenticity_token }, tag: 'span', class: 'login'
    end
  end

  def login
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      log_user_in(user)
      json_redirect_to faction_path
    else
      render json: { error: "Invalid username or password" }
    end
  end

  def logout
    session.destroy
    redirect_to login_path
  end

  def reset_password
  end
end
