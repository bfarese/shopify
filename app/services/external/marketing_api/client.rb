class External::MarketingApi::Client
  def initialize(args={})
    @api_key = args.fetch(:api_key) { ENV['PUB_API_KEY'] }
    @url     = args.fetch(:url) { "https://a.klaviyo.com/" }
  end

  def track(event, customer_properties, properties)
    params = {
      token: @api_key,
      event: event,
      customer_properties: customer_properties,
      properties: properties }

    params = build_params(params)
    request('api/track', params)
  end

  private

  def build_params(params)
    "data=#{CGI.escape Base64.encode64(JSON.generate(params)).gsub(/\n/,'')}"
  end

  def request(path, params)
    url = "#{@url}#{path}?#{params}"
    open(url).read == '1'
  end
end
