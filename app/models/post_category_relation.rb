class PostCategoryRelation < ApplicationRecord
    belongs_to :business_user
    belongs_to :category
    belongs_to :post
  
end
