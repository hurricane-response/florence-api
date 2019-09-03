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

  test 'import update unaltered shelter records' do
    VCR.use_cassette('fema_shelters') do
      # setup
      shelters = FemaImporter.shelters
      ImportFemaSheltersJob.perform_now

      # modify a shelter
      shelter = Shelter.first
      correct_value = shelter.shelter
      shelter.update_column(:shelter, 'This Shelter will be modified')

      # reimport
      ImportFemaSheltersJob.perform_now

      shelter.reload
      assert_equal correct_value, shelter.shelter
    end
  end

  test 'import does not update user-updated shelter records' do
    VCR.use_cassette('fema_shelters') do
      # setup
      shelters = FemaImporter.shelters
      ImportFemaSheltersJob.perform_now

      # mock a user edit
      shelter = Shelter.first
      correct_value = 'This Shelter was user-updated'
      shelter.assign_attributes(
        shelter: correct_value,
        updated_by: users(:admin),
      )
      shelter.save

      # reimport
      ImportFemaSheltersJob.perform_now

      shelter.reload
      assert_equal correct_value, shelter.shelter
    end
  end
end
