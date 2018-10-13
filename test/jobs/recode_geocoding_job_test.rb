require 'test_helper'

class RecodeGeocodingJobTest < ActiveJob::TestCase
  def setup
    @_original_lookup = Geocoder.config.lookup
    Geocoder.configure(lookup: :test)
    Geocoder::Lookup::Test.set_default_stub([mock_attributes])
  end

  def teardown
    # TODO: fix geocoder testing
    #Geocoder::Lookup::Test.reset
  end

  test 'Shelters get recoded' do
    assert_equal 3, Shelter.incomplete_geocoding.count, 'Invalid fixture data.'
    RecodeGeocodingJob.perform_now('Shelter')
    assert_equal 0, Shelter.incomplete_geocoding.count
  end

  test 'When an id is provider, only the referenced shelter gets updated' do
    shelter = shelters(:incomplete1)
    expectedCount = Shelter.incomplete_geocoding.count - 1
    RecodeGeocodingJob.perform_now('Shelter', shelter.id)
    assert_equal expectedCount, Shelter.incomplete_geocoding.count
  end

  test 'When a shelter is updated, all missing fields are filled' do
    shelter = shelters(:incomplete1)
    assert shelter.county.blank?
    assert shelter.city.blank?
    assert shelter.state.blank?
    assert shelter.zip.blank?
    RecodeGeocodingJob.perform_now('Shelter', shelter.id)
    shelter.reload
    refute shelter.county.blank?
    refute shelter.city.blank?
    refute shelter.state.blank?
    refute shelter.zip.blank?
  end

private

  def mock_attributes
    @mock_attributes ||= {
      'latitude'     => 37.7756906,
      'longitude'    => -122.4136764,
      'address'      => '149 9th St, San Francisco, CA 94103, USA',
      'city'         => 'San Francisco',
      'state'        => 'California',
      'state_code'   => 'CA',
      'postal_code'  => '94103',
      'country'      => 'United States',
      'country_code' => 'US',
      'sub_state'    => 'San Francisco County'
    }
  end
end
