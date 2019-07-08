class ProductPropertiesList
  attr_reader :raw_products, :order_id

  def self.call(raw_products, order_id)
    new(raw_products, order_id).call
  end

  def call
    run
  end

  private

  def initialize(raw_products, order_id)
    @raw_products  = raw_products
    @order_id     = order_id
  end

  def run
    raw_products.map { |product| set_properties(product) }
  end

  def set_properties(product)
    product['$event_id'] = "#{order_id}_#{product['id']}"
    product['$value'] = "#{set_product_value(product)}"
  end

  def set_product_value(product)
    Cents::Cent(product['price']) * product['quantity']
  end
end
