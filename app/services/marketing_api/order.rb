module MarketingApi
  class Order
    attr_reader :raw_order, :current_item

    def self.properties(raw_order)
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
      properties
    end

    def properties
      { "$event_id" => raw_order['id'],
        "$value"    => order_value,
        "ItemNames" => item_names,
        "Items"     => items }
    end

    def order_value
      order_value_in_cents.value_in_dollars
    end

    def order_value_in_cents
      Cents::Cent(raw_order['total_price'])
    end

    def item_names
      raw_order["line_items"].map { |item| item['title'] }
    end

    def items
      raw_order['line_items'].map do |item|
        @current_item = item

        {
          "ProductID"=>"#{item['product_id']}",
          "ProductName"=>item['title'],
          "Quantity"=>item['quantity'],
          "ItemPrice"=>item_price,
          "RowTotal"=>row_total
        }
      end
    end

    def item_price
      item_price_in_cents.value_in_dollars
    end

    def item_price_in_cents
      Cents::Cent(current_item['price'])
    end

    def row_total
      row_total_price_in_cents.value_in_dollars
    end

    def row_total_price_in_cents
      item_price_in_cents * current_item['quantity']
    end
  end
end
