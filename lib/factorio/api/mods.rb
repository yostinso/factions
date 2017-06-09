class Factorio::API::Mods < Factorio::API
  MOD_URL = URI.join(BASE_URL, "mods")

  def initialize(auth)
    @auth = auth
  end

  def get_by_name(name)
    url = URI.join(MOD_URL, name)
    resp = Net::HTTP.get.new(url)
    json = parse_json(resp.body)
    if resp.is_a?(Net::HTTPSuccess)
    else
      raise Factorio::API::Exception.new(self.class.name, json["detail"])
    end
  end

  def download()
  end
end
