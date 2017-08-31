require 'google/apis/sheets_v4'
class ImportSheltersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Starting ImportSheltersJob #{Time.now}"

    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = 'Harvey Needs'
    scopes =  ['https://www.googleapis.com/auth/drive']
    service.authorization = Google::Auth.get_application_default(scopes)
    spreadsheet_id = '14GHRHQ_7cqVrj0B7HCTVE5EbfpNFMbSI9Gi8azQyn-k'
    range = 'Shelters!A1:P'
    response = service.get_spreadsheet_values(spreadsheet_id, range)

    headers = response.values.shift.map(&:parameterize).map(&:underscore)

    ApplicationRecord.connection.transaction do
      Shelter.delete_all
      response.values.each do |row|
        values = Hash[headers.zip(row)]

        values["accepting"] = values["accepting"] =~ /true/i ? true : false

        Shelter.create! values
      end
      puts "ImportSheltersJob Complete - {#{response.values.count - 1}}"
    end
  end
end
