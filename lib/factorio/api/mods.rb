class Factorio::API::Mods < Factorio::API
  MOD_URL = URI.join(BASE_URL, "mods/")

  def requires_auth!
    raise Factorio::API::Exception.new(self.class.name, "Auth required!") unless @auth.try(:logged_in?)
  end

  def initialize(auth=nil)
    @auth = auth
  end

  def get_by_name(name)
    uri = URI.join(MOD_URL, name)
    resp = do_get(uri)
    json = parse_json(resp.body)
    if resp.is_a?(Net::HTTPSuccess)
      begin
        ::Mod.from_json(json)
      rescue ArgumentError => e
        raise Factorio::API::Error.new(self.class.name, "#{e.message}", e)
      end
    else
      raise Factorio::API::Error.new(self.class.name, json["detail"])
    end
  end

  def search
  end

  def download
  end
end
