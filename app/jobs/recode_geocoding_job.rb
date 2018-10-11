class RecodeGeocodingJob < ApplicationJob
  queue_as :default

  def perform(class_name = 'Shelter', *args)
    case class_name.classify
    when 'Shelter'
      logger.info "Recoding #{args.empty? ? 'any invalid' : args.length} shelters"
      shelters = Shelter.geo_recode(*args)
      logger.info "#{shelters.length} shelters reverse geocoded"
    when 'DistributionPoint'
      logger.info "Recoding #{args.empty? ? 'any invalid' : args.length} distribution points"
      shelters = DistributionPoint.geo_recode(*args)
      logger.info "#{shelters.length} distribution points reverse geocoded"
    else
      logger.error "Invalid class name ('#{class_name}') passed to RecodeGeocoding job."
    end
  end
end
