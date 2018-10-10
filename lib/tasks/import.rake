namespace :api do
  desc "Schedule import of records for needs and shelters"
  task :import => :environment do
    if Rails.env.development?
      ImportSheltersJob.perform_now
      ImportNeedsJob.perform_now
    else
      puts "Not running api:import because it's not development mode. Mode: #{Rails.env}"
    end
  end
end

namespace :fema do
  desc "Schedule an import from FEMA"
  task :import => :environment do
    ImportFemaSheltersJob.perform_now
  end
end

namespace :amazon do
  desc "Schedule import of Amazon Products"
  task :import => :environment do
    ScheduleAmazonFetchJob.perform_now
  end
end
