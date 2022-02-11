class Room < ApplicationRecord
    belongs_to :reservation
    has_many :messages, dependent: :destroy
    validates :reservation_id, uniqueness: true
    
    has_many :user_rooms
    has_many :business_user_rooms
    has_many :chats
    
end
