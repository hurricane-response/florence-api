require 'test_helper'
class NeedTest < ActiveSupport::TestCase

  test "the fixtures work" do
    assert_equal Need.count, 2
  end

  test "empty array if nothing" do
    need = Need.new
    array = need.clean_needs
    assert_equal 0, array.length
  end

  test "clean needs gets rid of opens at 6" do
    need = Need.new tell_us_about_the_supply_needs: "opens at 6,\n*perishable foods, \n*cleaning supplies"
    array = need.clean_needs
    assert_equal 2, array.length
    assert_equal "perishable foods", array.first
    assert_equal "cleaning supplies", array.last
  end

  test "clean needs gives nice array" do
    need = Need.new tell_us_about_the_supply_needs: "non-perishable foods, cleaning supplies"
    array = need.clean_needs
    assert_equal 2, array.length
    assert_equal "cleaning supplies", array.last
  end
end
