module MarketingApi
  class TrackOrder
    attr_reader :order, :http_client,
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
      @order                    = raw_order
      customer                  = raw_order['customer']
      line_items                = raw_order['line_items']
      order_id                  = raw_order['id']
      @http_client              = Registry.http_client
      @order_properties         = Registry.order(raw_order)
      @customer_properties      = Registry.customer(customer)
      @product_properties_list  = Registry.products(line_items, order_id)
    end

    def run
      track_data if valid_order?
    end

    def valid_order?
      order_paid? || payment_authorized?
    end

    def order_paid?
      order['financial_status'] == "paid"
    end

    def payment_authorized?
      order['financial_status'] == "authorized"
    end

    def track_data
      track_order
      track_product_properties_list
    end

    def track_order
      http_client.track({
        event: "Placed Order",
        customer_properties: customer_properties,
        properties: order_properties })
    end

    def track_product_properties_list
      product_properties_list.each { |properties| track_product(properties) }
    end

    def track_product(properties)
      http_client.track({
        event: "Ordered Product",
        customer_properties: customer_properties,
        properties: properties })
    end
  end
end
