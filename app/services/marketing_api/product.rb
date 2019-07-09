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
      properties
    end

    def properties
      { "$event_id"   => product_event_id,
        "$value"      => value,
        "ProductID"   => "#{product['product_id']}",
        "ProductName" => product['title'],
        "Quantity"    => product['quantity']}
    end

    def product_event_id
      "#{order_id}_#{product['product_id']}"
    end

    def value
      product_value_in_cents.value_in_dollars
    end

    def product_value_in_cents
      price_in_cents * product['quantity']
    end

    def price
      price_in_cents.value_in_dollars
    end

    def price_in_cents
      Cents::Cent(product['price'])
    end
  end
end
