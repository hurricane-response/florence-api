require 'google/apis/sheets_v4'
class ImportNeedsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Starting ImportNeedsJob #{Time.now}"

    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = 'Harvey Needs'
    scopes =  ['https://www.googleapis.com/auth/drive']
    service.authorization = Google::Auth.get_application_default(scopes)
    spreadsheet_id = '14GHRHQ_7cqVrj0B7HCTVE5EbfpNFMbSI9Gi8azQyn-k'
    range = 'Needs!A1:N'
    response = service.get_spreadsheet_values(spreadsheet_id, range)

    headers = response.values.shift.map(&:parameterize).map(&:underscore)

    ApplicationRecord.connection.transaction do
      Need.delete_all
      response.values.each do |row|
        values = Hash[headers.zip(row)]

        values["are_volunteers_needed"] = values["are_volunteers_needed"] =~ /no/i ? false : true

        values["are_supplies_needed"] = values["are_supplies_needed"] =~ /no/i ? false : true

        Need.create! values
      end
      puts "ImportNeedsJob Complete - {#{response.values.count - 1}}"

    end

    # schedule an update, but it's throttled to 1 every 10 minutes
    ScheduleAmazonFetchJob.perform_later
  end
end
