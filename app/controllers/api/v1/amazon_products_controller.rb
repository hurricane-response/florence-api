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
      @needs = @needs.select { |need| need =~ /#{params[:need]}/i }
    end

    @products = AmazonProduct
                  .active
                  .where(need: @needs)
                  .order("priority, need")

    if params[:priority].to_s == 'true'
      @filters[:priority] = params[:priority]
      @products = @products.priority
    end

    if params[:category].present?
      @filters[:category] = params[:category]
      cat_specific_field = AmazonProduct.arel_table[:category_specific]
      cat_general_field = AmazonProduct.arel_table[:category_general]
      @products = @products
        .where(cat_specific_field.matches("%#{params[:category]}%"))
        .or(@products.where(cat_general_field.matches("%#{params[:category]}%")))
    end

    if params[:limit].to_i > 0
      @filters[:limit] = params[:limit].to_i
      @products = @products.limit(params[:limit].to_i)
    end
  end
end
