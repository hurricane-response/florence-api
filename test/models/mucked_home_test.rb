require 'test_helper'

class MuckedHomeTest < ActiveSupport::TestCase

  test "MuckedHomes can be ordered by geo" do
    alan = mucked_homes(:alan)
    joe = mucked_homes(:joe)
    nearest_alan = MuckedHome.near([alan.latitude, alan.longitude], 100).first
    assert_equal nearest_alan, alan

    nearest_joe = MuckedHome.near([joe.latitude, joe.longitude], 100).first
    assert_equal nearest_joe, joe
  end

end
