#class BusinessUsers::MessagesController < BusinessUsers::ApplicationController
class BusinessUsers::MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save
      redirect_to business_users_room_path(message.room.reservation_id)
    else
      redirect_to business_users_room_path(message.room.reservation_id), alert: 'チャットを送信できませんでした'
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id).merge(business_user_id: current_business_user.id)
  end
end