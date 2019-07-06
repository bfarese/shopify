require 'webmock/rspec'
require 'api_mock_body'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|

  config.before(:each) do
    stub_request(
      :get,
      "https://paucek-considine6869.myshopify.com/admin/api/2019-07/orders.json?updated_at_max=2016-12-31&updated_at_min=2016-01-01" 
      ).with(
         headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=>'Basic NDkwZjQxZWRkOTJhMTBjNWIzYTQwNzU4NmE5YWZkZGM6MzcxNDY4MjZhOTg3YmM3ZDY0ZWVkYzZjY2FiNTc1ZWE=',
       	  'User-Agent'=>'Faraday v0.15.4'
         }
      ).to_return(
        status: 200,
        body: ApiMockBody.json,
        headers: {}
      )
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
