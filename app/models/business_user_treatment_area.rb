class BusinessUserTreatmentArea < ApplicationRecord
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :business_user
    belongs_to_active_hash :ward
end
