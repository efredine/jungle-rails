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

  def destroy
    # TODO: verify that the user deleting the reivew is this user
    @product = Product.find(params[:product_id])
    @review = Review.find params[:id]
    if @review.user.id == current_user.id
      @review.destroy
      redirect_to @product, notice: 'Review deleted!'
    else
      render status: :forbidden, plain: "Forbidden"
    end
  end

  private

    def review_params
      params.require(:review).permit(:rating, :description)
    end

end
