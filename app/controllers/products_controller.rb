class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    if flash[:review_with_errors]
      @review = Review.new(flash[:review_with_errors])
    else
      @review = Review.new
    end
    logger.debug flash.inspect
    logger.debug @review.inspect
  end

end
