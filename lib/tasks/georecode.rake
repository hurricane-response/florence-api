namespace :georecode do
  desc 'Rebuild the reverse geocoding fields (city, state, zip, county, address) on shelters from Google Places API'
  task shelters: :environment do |task, args|
    RecodeGeocodingJob.perform_now('Shelter', *args.extras)
  end

  desc 'Rebuild the reverse geocoding fields (city, state, zip, county, address) on Points of Distribution from Google Places API'
  task pods: :environment do |task, args|
    RecodeGeocodingJob.perform_now('DistributionPoint', *args.extras)
  end
end
