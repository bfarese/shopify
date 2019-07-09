module MarketingApi
  class Registry
    def self.client
      Client.new
    end

    def self.order(raw_order)
      Order.properties(raw_order)
    end

    def self.customer(raw_customer)
      Customer.properties(raw_customer)
    end

    def self.products(line_items, order_id)
      line_items.map { |line_item| Product.properties(line_item, order_id) }
    end
  end
end
