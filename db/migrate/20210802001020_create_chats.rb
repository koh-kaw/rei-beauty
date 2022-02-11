class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :message
      t.integer :business_user_id

      t.timestamps
    end
  end
end
