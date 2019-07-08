class External::MarketingApi::TrackOrder
  attr_reader :raw_order, :request_client,
              :order_properties, :customer_properties,
              :product_properties_list

  def self.call(raw_order)
    new(raw_order).call
  end

  def call
    run
  end

  private

  def initialize(raw_order)
    @request_client           = External::MarketingApi::Client.new
    @order_properties         = OrderProperties.call(raw_order)
    @customer_properties      = CustomerProperties.call(raw_order['customer'])
    @product_properties_list  = ProductPropertiesList.call(raw_order['line_items'])
  end

  def run
    track_data if order_paid_for?
  end

  def track_data
    track_order
    track_product_properties_list
  end

  def track_order
    request_client.track("Placed Order", customer_properties, order_properties)
  end

  def track_product_properties_list
    product_properties_list.each { |properties| track_product(properties) }
  end

  def track_product(properties)
    request_client.track("Ordered Product", customer_properties, properties)
  end

  def order_paid_for?
    raw_order['financial_status'] == "paid"
  end
end
