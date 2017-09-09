require 'test_helper'

class LocationDraftsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def drafts
    Draft.where("info->'organization' is not null").all
  end

  test "loads show for all types" do
    drafts.each do |draft|
      organization = draft.info['organization']
      legacy_table_name = draft.info['legacy_table_name']

      get location_draft_path(organization: organization, legacy_table_name: legacy_table_name, id: draft.id)
      assert_response :success
    end
  end

  test "accepts drafts for all types" do
    drafts.each do |draft|
      organization = draft.info['organization']
      legacy_table_name = draft.info['legacy_table_name']

      sign_in(users(:admin))
      post accept_location_draft_path(organization: organization, legacy_table_name: legacy_table_name, id: draft.id)
      assert_response :redirect
      draft = draft.reload
      record = Location::Whitelist.find(organization, legacy_table_name).find(draft.record_id)
      assert_equal(users(:admin), draft.accepted_by)
      # Assert the info on the draft matches the corresponding fields on the record
      draft.info.keys.each do |key|
        # We use record type to create the record for the draft if it is a new record
        # This field does not exist on the record, only in the draft
        # You cannot set a polymorphic type without also setting the id (as far as I know)
        next if 'record_type' == key
        if(record.send(key).nil?)
          assert_nil(draft.info[key], "Error #{key} not nil for #{draft.info['name']}")
        else
          assert_equal(record.send(key), draft.info[key], "Error for #{key} on #{draft.info['name']}")
        end
      end
    end
  end

  test "denies drafts for all types" do
    drafts.each do |draft|
      organization = draft.info['organization']
      legacy_table_name = draft.info['legacy_table_name']

      sign_in(users(:admin))
      delete location_draft_path(organization: organization, legacy_table_name: legacy_table_name, id: draft.id)
      assert_response :redirect
      draft = draft.reload
      record = draft.record
      assert_equal(users(:admin), draft.denied_by)
    end
  end
end
