class ReviewsController < ApplicationController
  before_action :authorize

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    if !@review.save
      flash[:review_with_errors] = @review
      flash[:error_messages] = @review.errors.full_messages
    end
    redirect_to @product
  end

  private

    def review_params
      params.require(:review).permit(:rating, :description)
    end

end
