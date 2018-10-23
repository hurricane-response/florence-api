class ImportFemaSheltersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Starting ImportFemaSheltersJob #{Time.now}"
    fema_data = FemaImporter.shelters
    imported = 0
    fema_data.each { |data| imported += deduplicated_import!(data) }
    logger.info "ImportFemaSheltersJob Complete - Records received: #{fema_data.length}, Imported Shelters: #{imported}"
  end

private

  def deduplicated_import!(data)
    # This is a very naive deduplication effort, yes it does
    # an unindexed scan of the database against several columns of text
    #
    # TODO: Use Arel for the where named functions
    # arel = Shelter.arel_table

    shelter = nil

    if shelter = find_by_address(data).first
      logger.info "Duplicate found by address: #{data[:shelter]} @ #{data[:address]}"
    elsif shelter = find_by_coordinates(data).first
      logger.info "Duplicate found by coordinates: #{data[:shelter]} @ [#{data[:latitude]}, #{data[:longitude]}]"
    elsif shelter = find_by_location_fields(data).first
      logger.info "Duplicate found by fields: #{data[:shelter]} @ [#{data[:city]}, #{data[:state]}, #{data[:zip]}]"
    elsif shelter = find_by_source(data).first
      logger.info "Duplicate found by source: #{data[:shelter]} @ [#{data[:source]}]"
    end

    if shelter.nil?
      active = data.delete(:active)
      data[:archived] ||= active.nil? ? false : !active
      Shelter.create!(data)
      1
    else
      unarchive!(shelter)
      0
    end
  end

  def find_by_address(data)
    Shelter.unscope(:where).where('LOWER(TRIM(address)) = ?', data[:address].strip.downcase)
  end

  def find_by_coordinates(data)
    lat = data[:latitude].to_f
    lon = data[:longitude].to_f
    delta = 0.0002
    shelter = Shelter.unscope(:where).where(
      '(latitude between ? and ?) AND (longitude between ? and ?)',
      lat - delta, lat + delta, lon - delta, lon + delta
    )
  end

  def find_by_location_fields(data)
    Shelter.unscope(:where).where(
      'LOWER(TRIM(shelter)) = ? AND LOWER(TRIM(city)) = ? AND LOWER(TRIM(state)) = ? AND LOWER(TRIM(zip)) = ?',
      data[:shelter].strip.downcase, data[:city].strip.downcase, data[:state].strip.downcase, data[:zip].strip.downcase
    )
  end

  def find_by_source(data)
    Shelter.unscope(:where).where('LOWER(TRIM(source)) = ?', data[:source].strip.downcase)
  end

  def unarchive!(shelter)
    if shelter.archived
      logger.info "Unarchiving pre-existing shelter with ID #{shelter.id}"
      shelter.update_columns(archived: false, updated_at: Time.now)
    end
  end
end
