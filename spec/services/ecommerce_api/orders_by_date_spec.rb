require 'rails_helper'

RSpec.describe EcommerceApi::OrdersByDate do
  let(:args) { { updated_at_min: "2016-01-01", updated_at_max: "2016-12-31" } }

  describe '.call' do
    it "accepts an optional hash" do
      expect(EcommerceApi::OrdersByDate.call()).to be_truthy
      expect(EcommerceApi::OrdersByDate.call(args)).to be_truthy
    end

    it "returns a list of orders" do
      orders = EcommerceApi::OrdersByDate.call

      expect(orders).to be_kind_of(Array)
    end
  end
end
