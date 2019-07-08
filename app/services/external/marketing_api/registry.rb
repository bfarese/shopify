module External
  module MarketingApi
    class Registry
      def self.client
        External::MarketingApi::Client.new
      end

      def self.order(raw_order)
        OrderProperties.call(raw_order)
      end

      def self.customer(raw_customer)
        CustomerProperties.call(raw_customer)
      end

      def self.products(line_items)
        ProductPropertiesList.call(line_items)
      end
    end
  end
end
