class Factorio::API
  BASE_URL = URI("https://mods.factorio.com/api")

  def parse_json(body)
    begin
      JSON.parse(body)
    rescue JSON::ParserError => e
      raise Factorio::API::Exception.new(self.class.name, "Unable to parse login response", e)
    end
  end
end
