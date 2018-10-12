require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'vcr'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  Geocoder.configure(lookup: :test)

  Geocoder::Lookup::Test.add_stub(
    [29.7488469, -95.4593152], [
      {
        'latitude'     => 29.7496888,
        'longitude'    => -95.45794269999999,
        'address'      => '4800 Hallmark Dr, Houston, TX 77056, USA',
        'city'         => 'Houston',
        'state'        => 'Texas',
        'state_code'   => 'TX',
        'country'      => 'United States',
        'country_code' => 'US',
        'sub_state'    => 'Harris County'
      }
    ]
  )

  Rails.application.load_tasks
end
