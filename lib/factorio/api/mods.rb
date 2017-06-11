class Factorio::API::Mods < Factorio::API
  MOD_URI = BASE_URL.merge("mods/")

  def requires_auth!
    raise Factorio::API::Exception.new(self.class.name, "Auth required!") unless @auth.try(:logged_in?)
  end

  def initialize(auth=nil)
    @auth = auth
  end

  def get_by_name(name)
    uri = MOD_URI.merge(name)
    resp = do_get(uri)
    handle_response(resp) do |json|
      ::Mod.from_json(json)
    end
  end

  def search(query, page: 1, page_size: 25, order: "top")
    uri = MOD_URI.merge(MOD_URI.path.sub(/\/$/, ""))
    params = {
      q: query,
      page: page,
      page_size: 25,
      order: order
    }

    uri = uri.merge("?" + params.to_query)
    resp = do_get(uri)
    handle_response(resp) do |json|
      json[:results].map { |res|
        ::Mod.from_json(res)
      }
    end
  end

  def download
  end

  private
  def handle_response(resp)
    json = parse_json(resp.body)
    if resp.is_a?(Net::HTTPSuccess)
      begin
        yield json
      rescue ArgumentError => e
        raise Factorio::API::Error.new(self.class.name, "#{e.message}", e)
      end
    else
      raise Factorio::API::Error.new(self.class.name, json["detail"])
    end
  end
end
