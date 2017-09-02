class Api::V1::HooksController < ApplicationController

  before_action do
    request.format = :json
  end

  def sheet_update
    ImportNeedsJob.perform_later
    ImportSheltersJob.perform_later
    head :ok
  end

end
