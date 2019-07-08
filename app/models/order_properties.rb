class OrderProperties
  attr_reader :raw_order

  def self.call(raw_order)
    new(raw_order).call
  end

  def call
    run
  end

  private

  def initialize(raw_order)
    @raw_order = raw_order
  end

  def run
    raw_order["$event_id"] = raw_order["id"]
    raw_order["$value"] = raw_order["total_price"]
    raw_order
  end
end
