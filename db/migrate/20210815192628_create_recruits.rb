class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.string :title
      t.text :content
      t.date :day
      t.date :from_day
      t.date :to_day
      t.integer :category_id
      t.time :start_time
      t.time :end_time
      t.integer :from_price
      t.integer :to_price
      t.string :area_id
      t.integer :user_id
      t.string :user_name

      t.integer :ward_id, array: true

      #t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
