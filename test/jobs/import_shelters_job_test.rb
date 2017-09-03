require 'test_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
end

class ImportSheltersJobTest < ActiveJob::TestCase

  setup do
    Shelter.destroy_all
  end

  test "imports the right amount of data" do
    VCR.use_cassette("shelters") do
      shelters = APIImporter.shelters
      ImportSheltersJob.perform_now
      sheltersCount = shelters.count
      recordsCount = Shelter.count
      assert_equal sheltersCount, recordsCount
    end
  end
end
