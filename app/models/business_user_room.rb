class BusinessUserRoom < ApplicationRecord
    belongs_to :room
    belongs_to :business_user
end
