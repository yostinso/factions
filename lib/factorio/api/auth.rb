class Factorio::API::Auth < Factorio::API

  LOGIN_URI = URI('https://auth.factorio.com/api-login')
  attr_accessor :username, :require_ownership
  attr_writer :password

  def initialize(username: username=nil, password: password=nil, token: token=nil, require_ownership: require_ownership=true)
    if username && password
      self.username = username
      self.require_ownership = require_ownership
      @password = password
      login!
    elsif token
      @login_token = token
    end
  end

  def login!
    resp = Net::HTTP.post_form(LOGIN_URI, username: @username, password: @password)
    json = parse_json(resp.body)

    if resp.is_a?(Net::HTTPSuccess)
      @login_token = json[0]
    else
      if json && json["message"] == "Insufficient membership"
        raise Factorio::API::Error.new(self.class.name, "No ownership found; please purchase the game.")
      elsif json
        raise Factorio::API::Error.new(self.class.name, json["message"])
      end
    end
  end

  def logged_in?
    @login_token.present?
  end

  def player_data
    {
      username: @username,
      token: @login_token,
    }
  end

end
