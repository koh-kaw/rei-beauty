class Profile < ApplicationRecord
    belongs_to :user
    belongs_to :business_user
    mount_uploader :avatar, ProfileAvatarUploader
end
