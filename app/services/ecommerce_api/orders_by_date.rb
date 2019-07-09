require 'faraday'

module EcommerceApi
  class OrdersByDate
    attr_reader :updated_at_min, :updated_at_max

    InvalidRequest = Struct.new(:reason) do
      def message
        reason || default_message
      end

      def default_message
        "Invalid arguments! Format as 'YEAR-MONTH-DAY' or '2016-12-31'"
      end 
    end

    def self.call(args={})
      new(args).call
    end

    def call
      orders || InvalidRequest.new
    end

    private

    def initialize(args)
      @updated_at_min = args.fetch(:updated_at_min) { "2016-01-01" }
      @updated_at_max = args.fetch(:updated_at_max) { "2016-12-31" }
      @key            = ENV["SHOPIFY_KEY"]
      @pass           = ENV["SHOPIFY_PASSWORD"]
      @store          = ENV["SHOPIFY_STORE"]
    end

    def orders
      parsed_response["orders"]
    end

    def parsed_response
      JSON.parse(response.body)
    end

    def response
      conn.get
    end

    def conn(http_client: Faraday)
      @conn ||= http_client.new(url: url) do |conn|
        conn.basic_auth key, pass
        conn.adapter :net_http
        conn.params["updated_at_min"] = updated_at_min
        conn.params["updated_at_max"] = updated_at_max
      end
    end

    def url
      "https://#{store}/admin/api/2019-07/orders.json"
    end

    private

    def key
      @key
    end

    def pass
      @pass
    end

    def store
      @store
    end
  end
end
