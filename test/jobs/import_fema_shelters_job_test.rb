require 'test_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :webmock
end

class ImportFemaSheltersJobTest < ActiveJob::TestCase
  setup do
    Shelter.destroy_all
  end

  test 'imports the right amount of data' do
    VCR.use_cassette('fema_shelters') do
      shelters = FemaImporter.shelters
      ImportFemaSheltersJob.perform_now
      assert_equal shelters.count, Shelter.count
    end
  end

  test 'multiple imports do not duplicate data' do
    VCR.use_cassette('fema_shelters') do
      shelters = FemaImporter.shelters
      ImportFemaSheltersJob.perform_now
      ImportFemaSheltersJob.perform_now
      ImportFemaSheltersJob.perform_now
      ImportFemaSheltersJob.perform_now
      assert_equal shelters.count, Shelter.count
    end
  end
end
