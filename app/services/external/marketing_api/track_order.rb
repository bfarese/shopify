module External
  module MarketingApi
    class TrackOrder
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

      def initialize(raw_order, registry: External::MarketingApi::Registry)
        @request_client           = registry.client
        @order_properties         = registry.order(raw_order)
        @customer_properties      = registry.customer(raw_order['customer'])
        @product_properties_list  = registry.products(raw_order['line_items'])
      end

      def run
        track_data if order_paid_for?
      end

      def order_paid_for?
        raw_order['financial_status'] == "paid"
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
