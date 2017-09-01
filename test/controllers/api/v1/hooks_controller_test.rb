require 'test_helper'

class Api::HooksControllerTest < ActionDispatch::IntegrationTest
  include ::ActiveJob::TestHelper

  test "ping triggers refresh" do

    assert_enqueued_with(job: ImportNeedsJob) do
      post "/api/v1/google-sheet-update"
    end

    assert_enqueued_with(job: ImportSheltersJob) do
      post "/api/v1/google-sheet-update"
    end
  end

end
