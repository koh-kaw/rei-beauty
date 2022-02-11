class InterviewRoom < ApplicationRecord
    has_many :interview_room_relations
    has_many :interview_chats
end
