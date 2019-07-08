class NullCustomer
  def self.properties
    {
      "$id"=>0,
      "email"=>"",
      "accepts_marketing"=>false,
      "created_at"=>"",
      "updated_at"=>"",
      "first_name"=>"",
      "last_name"=>"",
      "orders_count"=>0,
      "state"=>"disabled",
      "total_spent"=>"0.00",
      "last_order_id"=>0,
      "note"=>nil,
      "verified_email"=>false,
      "multipass_identifier"=>nil,
      "tax_exempt"=>false,
      "phone"=>nil,
      "tags"=>"",
      "last_order_name"=>"",
      "currency"=>"",
      "accepts_marketing_updated_at"=>"",
      "marketing_opt_in_level"=>nil,
      "tax_exemptions"=>[],
      "admin_graphql_api_id"=>"",
      "default_address"=> {
        "id"=>0,
        "customer_id"=>0,
        "first_name"=>"",
        "last_name"=>"",
        "company"=>"",
        "address1"=>"",
        "address2"=>"",
        "city"=>"",
        "province"=>"",
        "country"=>"",
        "zip"=>"",
        "phone"=>"",
        "name"=>"",
        "province_code"=>nil,
        "country_code"=>"",
        "country_name"=>"",
        "default"=>true
      }
    }
  end
end
