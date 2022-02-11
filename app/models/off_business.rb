class OffBusiness < ApplicationRecord
    belongs_to :business_user, dependent: :destroy
    
    def self.off_businesses_after_three_month
        # 今日から3ヶ月先までのデータを取得
        off_businesses = OffBusiness.all.where("off_day >= ?", Date.current).where("off_day < ?", Date.current >> 3).order(off_day: :desc)
        # 配列を作成し、データを格納
        # DBアクセスを減らすために必要なデータを配列にデータを突っ込んでます
        off_businesses_data = []
        off_businesses.each do |off_business|
          off_business_hash = {}
          off_business_hash.merge!(off_day: off_business.off_day.strftime("%Y-%m-%d"), off_time: off_business.off_time)
          off_businesses_data.push(off_business_hash)
        end
        off_businesses_data
    end

    validates :off_day, presence: true
    validates :off_time, presence: true
end
