require 'rails_helper'

RSpec.describe External::Ecommerce::Base do
  let(:base) { External::Ecommerce::Base.new }

  describe '#base_url' do
    it "returns the base url" do
      expect(base.url).to include("http")
    end
  end
end
