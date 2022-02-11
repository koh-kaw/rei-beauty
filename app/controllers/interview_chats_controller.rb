class InterviewChatsController < ApplicationController
    def show
        # Adminユーザーを代入
        @admin_user = User.find(1)
        @business_user = BusinessUser.find(params[:id])

        # Adminユーザーでサインインしてる時、InterviewRoomRelationテーブルにあるinterview_room_idの値の配列をinterview_roomsに代入
        if user_signed_in?
            interview_rooms = current_user.interview_room_relations.pluck(:interview_room_id)
        # interview_room_relationモデルからuser_idがチャット相手のidが一致するものと、
        # interview_room_idが上記interview_roomsのどれかに一致するレコードをinterview_room_relationsに代入。
            interview_room_relations = InterviewRoom.find_by(user_id: @admin_user.id, interview_room_id: interview_rooms)
        elsif business_user_signed_in?
            interview_rooms = current_business_user.interview_room_relations.pluck(:interview_room_id)
            interview_room_relations = InterviewRoom.find_by(business_user_id: @business_user.id, interview_room_id: interview_rooms)
        else
            # ログイン状態でなければルートパスにリダイレクトする
            flash[:alert] = "ログインしてください"
            redirect_back(fallback_location: root_path)
        end

        # もしinterview_room_relationが空でないなら
        unless interview_room_relations.nil?
            # @interview_roomに上記interview_room_relationのinterview_roomを代入
            @interview_room = interview_room_relations.interview_room
        else
            # それ以外は新しくinterview_roomを作り、
            @interview_room = InterviewRoom.new
            @interview_room.save
            # interview_room_relationを面接申請者(ビューティシャン)分とAdminユーザー分を作る
            InterviewRoomRelation.create(user_id: @admin_user.id, business_user_id: current_business_user.id, interview_room_id: @interview_room.id)
            #InterviewRoomRelation.create(user_id: @admin_user.id, interview_room_id: @interview_room.id)
        end
        @interview_chats = @interview_room.interview_chats
        @interview_chat = InterviewChat.new(interview_room_id: @interview_room.id)
      end
      
      def create
        @interview_chat = current_user.interview_chats.new(interview_chat_params)
        @interview_chat.save
        redirect_to request.referer
      end
        
      private
      def interview_chat_params
        params.require(:interview_chat).permit(:message, :interview_room_id)
      end
end