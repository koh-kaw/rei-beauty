class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :room, null: false, foreign_key: true #追加
      t.references :user, foreign_key: true #追加 NOT NULL制約はつけない
      t.references :business_user, foreign_key: true #追加 NOT NULL制約はつけない
      t.text :message, null: false
      t.string :image

      t.timestamps
    end
  end
end
