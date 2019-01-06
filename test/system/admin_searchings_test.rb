require 'application_system_test_case'

class AdminSearchingsTest < ApplicationSystemTestCase
  test 'Filtering the shelters' do
    visit shelters_path
    fill_in 'Search', with: shelters(:nrg).shelter
    assert_selector '#data-table', text: shelters(:nrg).shelter
    refute_selector '#data-table', text: shelters(:lonestar).shelter
  end

  test 'Filtering the needs' do
    visit needs_path
    fill_in 'Search', with: needs(:katy).location_name
    assert_selector '#data-table', text: needs(:katy).location_name
    refute_selector '#data-table', text: needs(:victory).location_name
  end

  test 'Notifications of shelter updates' do
    visit shelters_path
    sleep 1
    rando_shelter = Shelter.all.sample
    rando_shelter.shelter = SecureRandom.hex(8)
    rando_shelter.save!
    assert_selector '.new-record-notification', text: '1 RECENT SHELTER UPDATES - RELOAD'
  end

  test 'Notifications of need updates' do
    visit needs_path
    sleep 1
    rando_shelter = Need.all.sample
    rando_shelter.updated_by = SecureRandom.hex(8)
    rando_shelter.save!
    assert_selector '.new-record-notification', text: '1 RECENT NEED UPDATES - RELOAD'
  end
end
