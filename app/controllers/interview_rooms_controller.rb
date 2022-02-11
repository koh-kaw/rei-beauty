class InterviewRoomsController < ApplicationController
    def index
        @interview_room = InterviewRoomRelation.find_by(business_user_id: current_business_user.id)
    end
end
