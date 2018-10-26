require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  test 'Volunteers can be ordered by geo' do
    jane = volunteers(:jane)
    john = volunteers(:john)
    nearest_jane = Volunteer.near([jane.latitude, jane.longitude], 100).first
    assert_equal nearest_jane, jane

    nearest_john = Volunteer.near([john.latitude, john.longitude], 100).first
    assert_equal nearest_john, john
  end
end
