module MarketingApi
  class Customer
    attr_reader :raw_customer

    def self.properties(raw_customer)
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
      raw_customer ? customer : null_customer
    end

    def customer
      { "$email"=> raw_customer['email'],
        "$first_name"=> raw_customer['first_name'],
        "$last_name"=> raw_customer['last_name'] }
    end

    def null_customer
      { "$email"=>"null_user@gmail.com",
        "$first_name"=> "null first_name",
        "$last_name"=> "null last_name" }
    end
  end
end
