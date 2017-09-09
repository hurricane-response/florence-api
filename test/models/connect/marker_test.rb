require 'test_helper'

class Connect::MarkerTest < ActiveSupport::TestCase
  fixtures 'connect/markers'

  def setup
    @marker = connect_markers(:have)
  end

  test 'valid marker' do
    assert @marker.valid?
  end

  test 'invalid without a device uuid' do
    ['', nil].each do |blank|
      @marker.device_uuid = blank
      refute @marker.valid?, 'saved marker without a device uuid'
      assert_not_nil @marker.errors[:device_uuid], 'no validation error for device uuid present'
    end
  end

  test 'invalid without a name' do
    @marker.name = nil
    refute @marker.valid?, 'saved marker without a name'
    assert_not_nil @marker.errors[:name], 'no validation error for name present'
  end

  test 'invalid without categories' do
    @marker.categories = {}
    refute @marker.valid?, 'saved marker without categories'
    assert_not_nil @marker.errors[:categories], 'no validation error for categories present'
  end

  test 'invalid without a phone' do
    @marker.phone = nil
    refute @marker.valid?, 'saved marker without a phone'
    assert_not_nil @marker.errors[:phone], 'no validation error for phone present'
  end

  test 'invalid without a valid marker type' do
    @marker.marker_type = ''
    refute @marker.valid?, 'saved marker with an invalid marker type'
    assert_not_nil @marker.errors[:marker_type], 'no validation error for marker_type present'
  end

  test 'invalid without a latitude' do
    @marker.latitude = 0.0
    refute @marker.valid?, 'saved marker without a latitude'
    assert_not_nil @marker.errors[:latitude], 'no validation error for latitude'
  end

  test 'invalid without a longitude' do
    @marker.longitude = 0.0
    refute @marker.valid?, 'saved marker without a longitude'
    assert_not_nil @marker.errors[:longitude], 'no validation error for longitude'
  end

  test 'coordinates change when latitude changes' do
    @marker.latitude = 42
    assert @marker.coordinates_changed?, 'latitude changed'
  end

  test 'coordinates change when longitude changes' do
    @marker.longitude = 42
    assert @marker.coordinates_changed?, 'longitude changed'
  end

  test 'coordinates do not change when lat/lng is invalid' do
    @marker.latitude = 0
    @marker.longitude = 0
    refute @marker.coordinates_changed?, 'lat/lng are invalid'
  end

  test 'invalid with a bad email' do
    @marker.email = 'nope'
    refute @marker.valid?, 'saved marker with invalid email'
    assert_not_nil @marker.errors[:email], 'no validation error for email'
  end

  test 'scope by category' do
    assert Connect::Marker.by_category('labor').all? { |m| m.categories.keys.include?('labor') }
  end

  test 'scope by device uuid' do
    assert Connect::Marker.by_device_uuid(@marker.device_uuid).all? { |m| m.device_uuid == @marker.device_uuid }
  end

  test 'scope by type' do
    assert Connect::Marker.by_type(@marker.marker_type).all? { |m| m.marker_type == @marker.marker_type }
  end

  test 'scope resolved' do
    assert Connect::Marker.resolved.all? { |m| m.resolved }
  end

  test 'scope unresolved' do
    assert Connect::Marker.unresolved.none? { |m| m.resolved }
  end
end
