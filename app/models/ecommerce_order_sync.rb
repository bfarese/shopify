class EcommerceOrderSync
  def self.call
    new().call
  end

  def call
    run
  end

  private

  def initialize
  end

  def run
    orders = EcommerceApi::OrdersByDate.call

    orders.each do |order|
      MarketingApi::TrackOrder.call(order)
    end
  end
end
