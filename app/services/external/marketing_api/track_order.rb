module External
  module MarketingApi
    class TrackOrder
      attr_reader :order, :request_client,
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
        @request_client           = Registry.client
        @order_properties         = Registry.order(raw_order)
        @customer_properties      = Registry.customer(customer)
        @product_properties_list  = Registry.products(line_items, order_id)
      end

      def run
        self
        # track_data if order_paid_for?
      end

      def order_paid_for?
        order['financial_status'] == "paid"
      end

      def track_data
        track_order
        track_product_properties_list
      end

      def track_order
        request_client.track(
          "Placed Order",
          customer_properties,
          order_properties)
      end

      def track_product_properties_list
        product_properties_list.each { |properties| track_product(properties) }
      end

      def track_product(properties)
        request_client.track(
          "Ordered Product",
          customer_properties,
          properties)
      end
    end
  end
end
