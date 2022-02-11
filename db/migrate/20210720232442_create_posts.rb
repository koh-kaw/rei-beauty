class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :category_id, null: false
      t.integer :price, null: false
      t.integer :total_price, null: false
      t.integer :service_fee, null: false
      t.integer :trans_fee, null: false, default: 1000
      t.integer :cancel_price, null: false, default: 0
      t.string :image
      t.integer :business_user_id
      t.string :business_user_name
      t.integer :time, null: false
      t.time :start_time
      t.time :end_time
      t.integer :weekday
      t.integer :tax, null: false

      t.timestamps
    end
  end
end
