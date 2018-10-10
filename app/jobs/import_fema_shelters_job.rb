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
    # This is a very naive deduplication effort, yes it does
    # an unindexed scan of the database against several columns of text
    c1 = Shelter.unscope(:where).where(shelter: data[:shelter],
                                     city: data[:city],
                                     state: data[:state],
                                     zip: data[:zip]).count
    c2 = Shelter.unscope(:where).where(address: data[:address]).count
    c3 = Shelter.unscope(:where).where(source: data[:source]).count

    if c1 > 0 || c2 > 0 || c3 > 0
      logger.info "Duplicate: #{data[:shelter]} @ #{data[:address]}"
      true
    else
      false
    end
  end
end
