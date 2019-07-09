module External
  module MarketingApi
    class Product
      attr_reader :product, :order_id

      def self.properties(raw_product, order_id)
        new(raw_product, order_id).call
      end

      def call
        run
      end

      private

      def initialize(raw_product, order_id)
        @product  = raw_product
        @order_id = order_id
      end

      def run
        set_product_event_id
        set_product_value
        product
      end

      def set_product_event_id
        product['$event_id'] = "#{order_id}_#{product['id']}"
      end

      def set_product_value
        product['$value'] = "#{calculate_product_value}"
      end

      def calculate_product_value
        Cents::Cent(product['price']) * product['quantity']
      end
    end
  end
end
