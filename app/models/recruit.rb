class Recruit < ApplicationRecord
    #belongs_to:user
    #validates :user_id, {presence: true}

    def user
        #インスタンスメソッド内でselfはインスタンス自身を指す。
        return Recruit.find_by(id: self.id)
    end

    def self.search(user_search)
        #@user_name = User.find_by(id: :user_id)
        byebug
        return Recruit.all unless user_search
        byebug
        Recruit.where(['ward_id LIKE ?', "%#{user_search}%"])
    end

end
