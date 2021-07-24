class Menu < ApplicationRecord

  
    validates :image,
      content_type: [:png, :jpg, :jpeg],
      size: { less_than_or_equal_to: 10.megabytes },
      dimension: { width: { max: 2000 } , height: { max: 2000 } }
    validates :name, length: { maximum: 50 }, presence: true
    validates :place, length: { maximum: 100 }
    validates :place, presence: true
    validates :content, length: { maximum: 2000 }, presence: true
    validates :start_at
    validates :end_at
    validate :start_at_should_be_before_end_at
  

  
    private
  
    def remove_image_if_user_accept
      self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
    end
  
    def start_at_should_be_before_end_at
      return unless start_at && end_at
  
      if start_at >= end_at
        errors.add(:start_at, "は終了時間よりも前に設定してください")
      end
    end

end
