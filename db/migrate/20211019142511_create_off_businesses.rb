class CreateOffBusinesses < ActiveRecord::Migration[6.0]
  def change
    create_table :off_businesses do |t|
      t.date :off_day
      t.time :off_time
      t.datetime :start_date
      t.datetime :end_date
      t.references  :business_user, foreign_key: true
      
      t.timestamps
    end
  end
end
