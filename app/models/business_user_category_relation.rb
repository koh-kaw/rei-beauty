class BusinessUserCategoryRelation < ApplicationRecord
    belongs_to :business_user
    belongs_to :category
end
