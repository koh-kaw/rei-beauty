class BusinessUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  #validates :self_introduction, length: { maximum: 500 }

  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true
  
  enum sex: { woman: 0, man: 1 }

  mount_uploader :image, ImageUploader

  # カテゴリー
  has_many :business_user_category_relations
  has_many :category, through: :business_user_category_relations
  
  has_many :post_category_relations
  has_many :posts, through: :post_category_relations
  #has_many :category, through: :post_category_relations

  # 面接用チャット
  has_many :interview_room_relations
  has_many :interview_chats

  # Profile画面
  has_one :buser_profile

  #予約
  has_many :reservations, dependent: :destroy

  # 休業設定
  has_many :off_business, dependent: :destroy

  # チャット
  has_many :user_rooms
  has_many :chats
  has_many :messages, dependent: :destroy
  # チャットルームの中間テーブル
  has_many :business_user_rooms, dependent: :destroy

  # レビュー
  has_many :reviews

  # お気に入り機能
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  #ランキング
  has_many :ranking, dependent: :destroy

  # エリア
  has_many :business_user_treatment_areas
  has_many :wards, through: :business_user_treatment_areas
  
  #def wards
  #  business_user_treatment_areas.map(&:ward)
  #end


  # 検索

  

  # パスワード無しでユーザ設定をアップデート
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?

      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


  # 住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  validates :self_introduction, length: { maximum: 500 }
  
  enum bank_type: { saving: 0, checking: 1 }

end
