class Message < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :business_user, optional: true
    belongs_to :room

    validates :message, presence: true


# 後述(9. ブロードキャストジョブの作成)
  #after_create_commit { MessageBroadcastJob.perform_later self }

  # CarrierWave用の設定
  # Messageモデルのpicture属性とPictureUploaderクラスを紐付ける
  # PictureUploaderクラスは前述の3.画像アップローダ作成で作られている
  mount_uploader :image, ImageUploader

  # チャット画面でメッセージを上から最新順に表示するため
  # デフォルトで作成日の降順でデータを取得する設定
  default_scope  { order(created_at: :desc) }

end
