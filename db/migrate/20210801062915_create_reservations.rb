class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      #t.references :business_user, null: false, foreign_key: true

      t.datetime :start_date
      t.datetime :end_date

      t.date :day
      t.time :start_time
      t.time :end_time
      t.string :state
      t.string :station
      t.time :time
      t.integer :business_user_id
      t.integer :cancel_price
      t.integer :price
      t.integer :total_price
      t.integer :service_fee
      t.integer :trans_fee
      t.integer :tax

      t.string :postal_code
      t.string :prefecture_code
      t.string :city
      t.string :street

      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
