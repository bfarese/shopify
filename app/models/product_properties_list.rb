class ProductPropertiesList
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
    product['$event_id'] = "#{order_id}_#{product['id']}"
    product['$value'] = "#{set_product_value}"
    product
  end

  def set_product_value
    Cents::Cent(product['price']) * product['quantity']
  end
end
