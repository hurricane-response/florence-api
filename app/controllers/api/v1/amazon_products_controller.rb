class Api::V1::AmazonProductsController < ApplicationController

  def index
    # get all needs into a nice array
    # find all Amazon products we have
    needs = Need.all.map(&:clean_needs).flatten.uniq

    @products = AmazonProduct.where(need: needs)
  end
end
