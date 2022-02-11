class InterviewChat < ApplicationRecord
    belongs_to :user
    belongs_to :business_user
    belongs_to :interview_room
end
