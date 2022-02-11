class CreateBusinessUserRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :business_user_rooms do |t|
      t.integer :business_user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
