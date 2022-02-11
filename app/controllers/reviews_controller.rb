class ReviewsController < ApplicationController
    def create
      @review = Review.new(review_params)
      byebug
      @review.save
      redirect_to mypage_path
    end
  
    private
      def review_params
        params.require(:review).permit(:comment, :user_id, :business_user_id, :rate)
      end
  end