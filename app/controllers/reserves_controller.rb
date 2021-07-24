class ReservesController < ApplicationController
    before_action :authenticate_user!
  
    def create
      post = Post.find(params[:post_id])
  
      if current_user == post.business_user
        flash[:alert] = "オーナーが予約することはできません。"
      else
  
          start_date = Date.parse(reservation_params[:start_date])
          end_date = Date.parse(reservation_params[:end_date])
          days = (end_date - start_date).to_i + 1
  
          @reserve = current_user.reservations.build(reservation_params)
          @reserve.post = post
          @reserve.price = post.price
          @reserve.save
  
          flash[:notice] = "予約が完了しました。"
        end
        redirect_to post
    end
  
  
    private
      def reservation_params
        params.require(:reserve).permit(:start_date, :end_date)
      end
end
  