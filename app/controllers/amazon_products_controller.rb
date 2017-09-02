class AmazonProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_headers

  def index
    @amazon_products = AmazonProduct.all
  end

  def show
    @amazon_product = AmazonProduct.find params[:id]
  end

  def edit
    @amazon_product = AmazonProduct.find params[:id]
  end

  def update
    @amazon_product = AmazonProduct.find params[:id]
    if @amazon_product.update amazon_product_params
      redirect_to @amazon_product, notice: 'Shelter was successfully created.'
    else
      render :edit
    end
  end

  private
  def set_headers
    @columns = AmazonProduct::ColumnNames
    @headers = AmazonProduct::HeaderNames
  end

  def amazon_product_params
    params.require(:amazon_product).permit(AmazonProduct::UpdateFields).keep_if { |_,v| v.present? }
  end
end
