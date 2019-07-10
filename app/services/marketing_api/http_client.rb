require 'faraday'

module MarketingApi
  class HttpClient
    attr_reader :api_key, :base_url, :event,
                :customer_properties, :properties

    def self.track(args={})
      new(args).call
    end

    def call
      track
    end

    private

    def initialize(args={})
      @api_key              = args.fetch(:api_key) { ENV['PUB_API_KEY'] }
      @base_url             = args.fetch(:base_url) { "https://a.klaviyo.com/" }
      @event                = args.fetch(:event) { "" }
      @customer_properties  = args.fetch(:customer_properties) { {} }
      @properties           = args.fetch(:properties) { {} }
    end

    def track
      request('api/track')
    end

    def request(path)
      url = "#{base_url}#{path}?#{encoded_params}"
      conn(url).get
    end

    def encoded_params
      "data=#{CGI.escape Base64.encode64(JSON.generate(params)).gsub(/\n/,'')}"
    end

    def params
      { token: api_key,
        event: event,
        customer_properties: customer_properties,
        properties: properties }
    end

    def conn(url, http_client: Faraday)
      http_client.new(url: url) do |conn|
        conn.adapter :net_http
      end
    end
  end
end
