require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # Location is not used directly but as a parent class.
  # Setup a child for testing
  class Child < Location
    config(
      organization: 'sketch-city',
      legacy_table_name: 'shelters'
    )
    filter(:coordinates)
    filter(:limit)
    filter(:shelter)
    filter(:accepting, type: :truthy)
    legacy_field(:monkeys, legacy_column: 'Big monkeys')
    legacy_field(:elephants, type: :boolean, legacy_column: 'Max Elephants', display: false, updatable: false, admin_only: true)
    legacy_field(:tigers, type: :text, legacy_column: 'Max Tigers', display: false, updatable: false)
  end
  class OtherChild < Location
    config(
      organization: 'sketch-city',
      legacy_table_name: 'rescues'
    )
  end

  test 'correct organization and legacy_table_name' do
    assert_equal('sketch-city', Child.organization, 'Incorrect organization')
    assert_equal('Sketch City', Child.organization_display_name, 'Incorrect organization display name')
    assert_equal('shelters', Child.legacy_table_name, 'Incorrect legacy table name')
    assert_equal('Shelters', Child.legacy_table_display_name, 'Incorrect legacy table display name')
  end
  test 'sets filters correctly' do
    assert_equal(:coordinates, Child.filters[:coordinates].type, 'Coordinates filter set improperly')
    assert_equal(:limit, Child.filters[:limit].type, 'Limit filter set improperly')
    assert_equal(:string, Child.filters[:shelter].type, 'String filter set improperly')
    assert_equal(:truthy, Child.filters[:accepting].type, 'Boolean filter set improperly')
  end
  test 'sets columns, header, updatable columns correctly' do
    assert_equal(%i[name address city state zip phone monkeys], Child.table_columns, 'Columns set incorrectly')
    assert_equal(%w[Name Address City State Zip Phone Monkeys], Child.table_headers, 'Headers set incorrectly')
    assert_equal(['Name', 'Address', 'City', 'State', 'Zip', 'Phone', 'Big monkeys'], Child.legacy_headers, 'Legacy headers set incorrectly')

    assert_equal([:elephants], Child.admin_columns, 'Admin columns set incorrectly')
    assert_equal(['Elephants'], Child.admin_headers, 'Admin headers set incorrectly')
    assert_equal(['Max Elephants'], Child.admin_legacy_headers, 'Admin legacy headers set incorrectly')

    assert_equal(%i[name address city state zip phone monkeys], Child.update_fields.map(&:name), 'Updatable fields set incorrectly')
  end
  test 'sets legacy values on instance correctly' do
    child = Child.new(monkeys: 'bob')
    assert_equal(child.monkeys, 'bob', 'Strings for legacy data set incorrectly')

    [1, true, 'y'].each do |value|
      child = Child.new(elephants: value)
      assert_equal(true, child.elephants, "Booleans unable to process #{value}")
    end
  end
  test 'default scope restricts results' do
    Child.create(monkeys: 'bob')

    assert_equal(0, OtherChild.count)
    assert_equal(1, Child.count)
  end
end
