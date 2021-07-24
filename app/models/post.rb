class Post < ApplicationRecord
    has_many :post_category_relations
    has_many :categories, through: :post_category_relations
    belongs_to :category
    # お気に入り機能
    belongs_to :user, optional: true
    has_many :favorites, dependent: :destroy

    def self.search(keyword)
        where(["title like? OR content like?", "%#{keyword}%", "%#{keyword}%"])
    end

    def buser
        return BusinessUser.find_by(id: self.buser_id)
     end

    def posts
        return Post.where(buser_id: self.id)
    end
end
