# Expects ~/.factions_auth.json to contain
# { "username": "factorio_username", "password": "factorio_password" }
# or
# { "token": "abcde211231" }
module FactionsTest
  AUTH_FILE = File.expand_path("~/.factions_auth.json")
  def get_test_auth
    if !defined?(@@_test_auth)
      if File.exists?(AUTH_FILE)
        auth_json = JSON.parse(File.read(AUTH_FILE)).with_indifferent_access
        if auth_json.has_key?(:token)
          @@_test_auth = Factorio::API::Auth.new(token: auth_json[:token])
        else
          @@_test_auth = Factorio::API::Auth.new(username: auth_json[:username], password: auth_json[:password])
        end
      else
        raise "No ~/.factions_auth.json file found!"
      end
    end
    @@_test_auth
  end
  module_function :get_test_auth
end
