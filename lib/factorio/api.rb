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

  # TODO: Handle bad auth
  def do_get(uri, headers = DEFAULT_HEADERS, auth: auth=nil, redirect_limit: redirect_limit = 3, &block)
    if auth.present?
      new_q = "?" + [uri.query, auth.player_data.to_query].join("&")
      uri = uri.merge(new_q)
    end
    req = Net::HTTP::Get.new(uri, headers)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req) do |response|
        if response.is_a?(Net::HTTPRedirection)
          location = URI(response['Location'])
          raise Factorio::API::Error.new(self.class.name, "Too many redirects") if redirect_limit <= 0
          do_get(location, headers, redirect_limit: redirect_limit - 1, &block)
        else
          if block_given?
            yield(response)
          else
            response
          end
        end
      end
    end
  end

  def do_download(uri, io, headers = DEFAULT_HEADERS, auth: auth=nil)
    do_get(uri, headers, auth: auth) do |response|
      file_size = response["Content-Length"].to_i
      fetched = 0
      response.read_body do |chunk|
        io.write(chunk)
        fetched += chunk.size
        yield(fetched, file_size) if block_given?
      end
    end
  end
end
