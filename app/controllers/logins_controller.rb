class LoginsController < ApplicationController
  def index
    render component: 'pages/LoginPage', props: { }, tag: 'span', class: 'login'
  end

  def login
  end

  def logout
  end

  def reset_password
  end
end
