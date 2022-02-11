class ChatsController < ApplicationController
    def show
        # どのユーザーとチャットするかを取得。
        @user = User.find(params[:id])
        @business_user = BusinessUser.find(params[:id])
        
        # カレントユーザーのuser_roomにあるroom_idの値の配列をroomsに代入。
        if user_signed_in?
            rooms = current_user.user_rooms.pluck(:room_id)
        elsif business_user_signed_in?
            rooms = current_business_user.user_rooms.pluck(:room_id)
        else
            flash[:alert] = "ログインしてください"
            redirect_back(fallback_location: root_path)
        end
        # user_roomモデルからuser_idがチャット相手のidが一致するものと、room_idが上記roomsのどれかに一致するレコードをuser_roomsに代入。
        user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

        # もしuser_roomが空でないなら
        unless user_rooms.nil?
            # @roomに上記user_roomのroomを代入
            @room = user_rooms.room
        else
            # それ以外は新しくroomを作り、
            @room = Room.new
            @room.save
            # user_roomをカレントユーザー分とチャット相手分を作る
            if user_signed_in?
                UserRoom.create(user_id: current_user.id, room_id: @room.id)
                #UserRoom.create(user_id: @user.id, room_id: @room.id)
                UserRoom.create(business_user_id: @business_user.id, room_id: @room.id)
            elsif business_user_signed_in?
                UserRoom.create(business_user_id: current_business_user.id, room_id: @room.id)
                #UserRoom.create(user_id: @business_user.id, room_id: @room.id)
                UserRoom.create(user_id: @user.id, room_id: @room.id)
            end
        end
        @chats = @room.chats
        @chat = Chat.new(room_id: @room.id)
    end

    def new
        @chat = current_user.chats.new(chat_params)
        @chat.save
        redirect_to request.referer
    end
    
    # 面接用のチャットルームを作成
    def business_user_pre_register
        # Adminユーザーを指定
        @user = User.find(1)
        @business_user = BusinessUser.find(params[:id])

        @room = Room.new
        @room.save
        # user_roomをカレントユーザー分とチャット相手分を作る
        UserRoom.create(user_id: @user.id, room_id: @room.id)
        UserRoom.create(business_user_id: @business_user.id, room_id: @room.id)
    
        @chats = @room.chats
        @chat = Chat.new(room_id: @room.id)

        #redirect_to request.referer
    end

    def create
        @chat = current_user.chats.new(chat_params)
        @chat.save
        redirect_to request.referer
    end
  
    private
    def chat_params
        params.require(:chat).permit(:message, :room_id)
    end
end