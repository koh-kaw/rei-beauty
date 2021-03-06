class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :post
  #belongs_to :business_user
  
  # 予約に紐づくチャット
  has_one :room, dependent: :destroy
  # 予約に紐づくレビュー
  has_many :reviews

  # 予約情報を参照
  def self.reservations_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    # 配列を作成し、データを格納

    # DBアクセスを減らすために必要なデータを配列にデータを入れる
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"), time: reservation.time)
      reservation_data.push(reservations_hash)
    end
    reservation_data
  end

  validates :day, presence: true
  validates :time, presence: true
end


