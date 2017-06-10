class Factorio::API
  BASE_URL = URI("https://mods.factorio.com/api/")

  def parse_json(body)
    begin
      JSON.parse(body).with_indifferent_access
    rescue JSON::ParserError => e
      raise Factorio::API::Error.new(self.class.name, "Unable to parse JSON response", e)
    end
  end

  def do_get(uri, headers = { "Content-Type" => "application/json" })
    req = Net::HTTP::Get.new(uri, headers)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end
end
