require 'test_helper'

class ScheduleAmazonFetchJobTest < ActiveJob::TestCase

  setup do
    Need.destroy_all
    AmazonProduct.destroy_all
  end

  test "schedules for the correct need" do
    Need.create! tell_us_about_the_supply_needs: "trash bags (kitchen and contractor size)"

    assert_enqueued_with(job: FetchAmazonProductJob, args: ["trash bags (kitchen and contractor size)"]) do
      ScheduleAmazonFetchJob.perform_now
    end
  end

  test "schedules for each need" do
    Need.create! tell_us_about_the_supply_needs: "opens at 6pm\n*trash bags (kitchen and contractor size), baby formula"

    assert_enqueued_jobs 2 do
      ScheduleAmazonFetchJob.perform_now
    end
  end
end
