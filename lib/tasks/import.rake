namespace :google do

  desc "Schedule import of records for needs and shelters"
  task :import => :environment do
    ImportSheltersJob.perform_now
    ImportNeedsJob.perform_now
  end
end

namespace :amazon do
  desc "Schedule import of Amazon Products"
  task :import => :environment do
    ScheduleAmazonFetchJob.perform_now
    sleep 300
  end
end
