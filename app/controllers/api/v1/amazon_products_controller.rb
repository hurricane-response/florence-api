class Api::V1::AmazonProductsController < ApplicationController

  before_action do
    request.format = :json
  end

  def index
    @filters = {}
    # get all needs into a nice array
    # find all Amazon products we have
    @needs = Need.all.map(&:clean_needs).flatten.uniq

    if params[:need].present?
      @filters[:need] = params[:need]
      @needs = @needs.select{|need| need =~ /#{params[:need]}/i }
    end

    @products = AmazonProduct
                  .active
                  .where(need: @needs)

    if params[:priority] == true
      @filters[:priority] = params[:priority]
      @products = @products.priority
    end

    if params[:limit].to_i > 0
      @products = @products.limit(params[:limit].to_i)
    end
  end
end
