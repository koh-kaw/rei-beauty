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
  
  has_many :post_category_relations
  has_many :posts, through: :post_category_relations
  has_many :category, through: :post_category_relations
  
end
