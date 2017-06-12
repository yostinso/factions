class Factorio::API
  BASE_URI = URI("https://mods.factorio.com/api/")
  DEFAULT_HEADERS = { "Content-Type" => "application/json" }

  def parse_json(body)
    begin
      json = JSON.parse(body)
      json.is_a?(Hash) ? json.with_indifferent_access : json
    rescue JSON::ParserError => e
      raise Factorio::API::Error.new(self.class.name, "Unable to parse JSON response", e)
    end
  end

  # TODO: Handle lack of auth
  def do_get(uri, headers = DEFAULT_HEADERS, auth: auth=nil)
    if auth.present?
      new_q = "?" + [uri.query, auth.player_data.to_query].join("&")
      uri = uri.merge(new_q)
    end
    req = Net::HTTP::Get.new(uri, headers)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      if block_given?
        yield(http, req)
      else
        http.request(req)
      end
    end
  end

  def do_download(uri, io, headers = DEFAULT_HEADERS, auth: auth=nil)
    do_get(uri, headers, auth: auth) do |http, req|
      http.request(req) do |response|
        file_size = response["Content-Length"]
        fetched = 0
        puts "REDIRECTED #{response['Location']}"
        response.read_body do |chunk|
          puts "FETCHED"
          io.write(chunk)
          fetched += chunk.size
          yield(fetched, file_size) if block_given?
        end
      end
    end
  end
end
