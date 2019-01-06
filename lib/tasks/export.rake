namespace :shelters do
  desc 'Schedule export of shelters records'
  task export: :environment do
    SheltersCsvExportJob.perform_now
  end
end
