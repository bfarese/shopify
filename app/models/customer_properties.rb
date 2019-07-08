class CustomerProperties
  def self.call(raw_customer)
    new(raw_customer).call
  end

  def call
    run
  end

  private

  def initialize(raw_customer)
    @raw_customer = raw_customer
  end

  def run
    raw_customer ? format_customer : NullCustomer.properties
  end

  def format_customer
    raw_customer["$id"] = raw_customer['id']
    raw_customer
  end
end
