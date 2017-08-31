namespace :google do

  desc "Schedule import of records for needs and shelters"
  task :import => :environment do
    ImportSheltersJob.perform_now
    ImportNeedsJob.perform_now
  end
end
