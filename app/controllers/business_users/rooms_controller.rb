class BusinessUsers::RoomsController < ApplicationController
    before_action :set_room, only: :show
  
    def index
      @reservations = Reservation.includes(:user).order(day: "DESC")
      
      @reserves = Reservation.includes(:user).order(start_date: :asc)

      @rooms = Room.includes(:user).order(start_date: :desc)
    end
  
    def show
      @message = Message.new
      @messages = Message.where(room_id: @room.id)
  
      # 来店日を3日以上過ぎている予約判定の為、変数定義
      #@close_reservation = @room.reservation if @room.reservation.date < Date.today - 2

      @reservation = Reservation.find(params[:id])
      @business_user = BusinessUser.find(@reservation.business_user_id)
      @user = User.find(@reservation.user_id)
    end
  
    private
    def set_room
      #予約に紐づくルームを@roomに定義
      @room = Room.find_by(reservation_id: params[:id])
  
      # roomが存在するか判定し、存在しない場合にreservation_idを渡して作成する
      if @room.nil?
        @room = Room.new(reservation_id: params[:id])
        redirect_to rooms_path, alert: 'チャットルームに入れませんでした' unless @room.save
      end
    end


end
