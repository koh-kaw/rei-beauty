class Post < ApplicationRecord
    has_many :post_category_relations
    has_many :categories, through: :post_category_relations
    belongs_to :category

    #予約機能
    has_many :reservations

    # イメージ
    mount_uploader :image, ImageUploader

    # お気に入り機能
    #belongs_to :user, optional: true
    #has_many :favorites, dependent: :destroy
    #has_many :favorited_users, through: :favorites, source: :user

    def self.search(keyword, ward, category)
        
        if category.present? && keyword.present? && ward.blank?
            c = where(category_id: category)
            c.where(["title like? OR content like? OR business_user_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])

        elsif category.blank? && keyword.present? && ward.blank?
            where(["title like? OR content like? OR business_user_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])

        elsif category.present? && keyword.blank? && ward.blank?
            where(category_id: category)

        elsif category.blank? && keyword.blank? && ward.present?
            areas = BusinessUserTreatmentArea.where(ward_id: ward).pluck(:business_user_id)
            Post.where(business_user_id: areas)

        elsif category.present? && keyword.blank? && ward.present?
            c = where(category_id: category)
            areas = BusinessUserTreatmentArea.where(ward_id: ward).pluck(:business_user_id)
            c.where(business_user_id: areas)

        elsif category.blank? && keyword.present? && ward.present?
            areas = BusinessUserTreatmentArea.where(ward_id: ward).pluck(:business_user_id)
            a= Post.where(business_user_id: areas)
            a.where(["title like? OR content like? OR business_user_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])

        elsif category.present? && keyword.present? && ward.present?
            c = where(category_id: category)
            areas = BusinessUserTreatmentArea.where(ward_id: ward).pluck(:business_user_id)
            a = c.where(business_user_id: areas)
            a.where(["title like? OR content like? OR business_user_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])

        elsif category.blank? && keyword.blank? && ward.blank?
            keyword = "      "
            where(["title like? OR content like? OR business_user_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
            
        end
        
        #return result
    end


    def self.pickup(category)
        Post.where(category_id: category)
    end


    def buser
        return BusinessUser.find_by(id: self.buser_id)
     end

    def posts
        return Post.where(buser_id: self.id)
    end
end
