class ImportFemaSheltersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Starting ImportFemaSheltersJob #{Time.now}"
    fema_data = FemaImporter.shelters
    duplicates = 0
    fema_data.each do |data|
      if duplicate?(data)
        duplicates += 1
      else
        Shelter.create!(data)
      end
    end
    logger.info "ImportFemaSheltersJob Complete - Imported Shelters: #{fema_data.count - duplicates}"
  end

private

  def duplicate?(data)
    if Shelter.where(shelter: data[:shelter], city: data[:city], state: data[:state], zip: data[:zip]).count > 0 \
        || Shelter.unscope(:where).where(address: data[:address]).count > 0
      logger.info "Duplicate: #{data[:shelter]} @ #{data[:address]}"
      true
    else
      false
    end
  end
end
