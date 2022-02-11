class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2 line]

  # クレジットカード
  has_one :card, dependent: :destroy

  

  # LINE
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end

  # Google
  #byebug
  #def self.find_for_oauth(auth)
  #  user = User.where(uid: auth.uid, provider: auth.provider).first
#
  #  unless user
  #    user = User.create(
  #      uid:      auth.uid,
  #      provider: auth.provider,
  #      email:    User.dummy_email(auth),
  #      password: Devise.friendly_token[0, 20]
  #    )
  #  end
#
  #  user
  #end

  # omniauthのコールバック時に呼ばれるメソッド
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # deviseのuserカラムに name を追加している場合は以下のコメントアウトも追記します
      #user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  #def self.from_omniauth(auth)
  #  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #    user.email = auth.info.email
  #    user.password = Devise.friendly_token[0,20]
  #  end
  #end


  # エリア
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :ward

  # 住所自動入力
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
  # 面接用チャット
  has_many :interview_room_relations
  has_many :interview_chats

  # 予約機能
  has_many :posts
  has_many :reservations, dependent: :destroy
  
  # お気に入り機能
  has_many :business_users
  has_many :favorites, dependent: :destroy
  #has_many :favorited_posts, through: :favorites, source: :post
  has_many :favorited_business_users, through: :favorites, source: :business_user

  # プロフィール
  has_one :profile
  has_one_attached :avatar

  # チャット
  has_many :user_rooms
  has_many :chats
  has_many :messages, dependent: :destroy

  # レビュー
  has_many :reviews

  # 施術者募集
  has_many :recruits, dependent: :destroy

  # プロフィールイメージアップロード機能
  #mount_uploader :avatar, ProfileAvatarUploader
  mount_uploader :image, ImageUploader


  
  # パスワード無しで編集するための機能
  def update_without_current_password(params, *options)
    #params.delete(:current_password)でcurrent_password のパラメータを削除
    params.delete(:current_password)

    #パスワード変更のためのパスワード入力フィールドとその確認フィールドの両者とも空の場合のみ、パスワードなしで更新できるようにするため
    if params[:password].blank? && params[:password_confirmation].blank?

      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # 同意チェックボックス
  #validates_acceptance_of :agreement, allow_nil: false, on: :create



 # お気に入り
  def already_favorited?(business_user)
    self.favorites.exists?(business_user_id: business_user.id)
  end

  # 施術者募集
  def recruits
    return Recruit.where(user_id: self.id)
  end

  #attr_accessor :current_password
  # ユーザー登録時のみパスワードを検証する
  validate :password, on: :create
  # メールアドレスが登録されている事を確認する
  validates :email, presence: true
  # 自己紹介文を500文字までに設定
  validates :self_introduction, length: { maximum: 500 }
  # 性別で0が入力された時男、1の時女とする
  enum gender: { man: 0, woman: 1 }

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
