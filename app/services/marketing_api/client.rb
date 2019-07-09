require 'faraday'

module MarketingApi
  class Client
    def initialize(args={})
      @api_key  = args.fetch(:api_key) { ENV['PUB_API_KEY'] }
      @base_url = args.fetch(:base_url) { "https://a.klaviyo.com/" }
    end

    def track(event, customer_properties, properties)
      params = {
        token: api_key,
        event: event,
        customer_properties: customer_properties,
        properties: properties }

      params = build_params(params)
      request('api/track', params)
    end

    private

    def api_key
      @api_key
    end

    def build_params(params)
      "data=#{CGI.escape Base64.encode64(JSON.generate(params)).gsub(/\n/,'')}"
    end

    def request(path, params)
      url = "#{base_url}#{path}?#{params}"
      conn(url).get
    end

    def conn(url, http_client: Faraday)
      @conn ||= http_client.new(url: url) do |conn|
        conn.adapter :net_http
      end
    end

    def base_url
      @base_url
    end
  end
end
