class External::Ecommerce::Orders < External::Ecommerce::Base
  attr_reader :body

  def self.call(args={})
    new(args).call
  end

  def call
    JSON.parse(response.body)
  end

  private

  def initialize(args)
    @body = args.fetch(:body) { '{
      "updated_at_min":"2016-01-01",
      "updated_at_max":"2016-12-31"
      }'
    }
  end

  def response
    conn.get do |req|
      req.url "/admin/api/2019-07/orders.json"
      req.headers['Content-Type'] = 'application/json'
      req.body = body
    end
  end
end
