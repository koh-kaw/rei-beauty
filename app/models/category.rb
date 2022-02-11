class Category < ApplicationRecord
    has_many :post_category_relations
    has_many :business_user_category_relations
    has_many :posts, through: :post_category_relations
    has_many :business_users, through: :post_category_relations
    has_many :business_users, through: :business_user_category_relations
    accepts_nested_attributes_for :business_user_category_relations
end
