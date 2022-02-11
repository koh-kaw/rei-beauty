class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.references :reservation, foreign_key: true #追加
      t.timestamps
    end
  end
end
