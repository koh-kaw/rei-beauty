class Chat < ApplicationRecord
    belongs_to :user
    belongs_to :business_user
    belongs_to :room
end
