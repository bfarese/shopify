require 'faraday'

class External::Ecommerce::Base
  def initialize()
    @key    = ENV["SHOPIFY_KEY"]
    @pass   = ENV["SHOPIFY_PASSWORD"]
    @store  = ENV["SHOPIFY_STORE_URL"]
  end

  def conn(http_client: Faraday)
    @conn ||= http_client.new(
      url: url,
      ssl: { ca_file: '/usr/local/etc/openssl/cert.pem' })
  end

  def url
    "https://#{key}:#{pass}@#{store}.myshopify.com"
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
