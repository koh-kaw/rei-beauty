class CreateInterviewChats < ActiveRecord::Migration[6.0]
  def change
    create_table :interview_chats do |t|
      t.integer :user_id
      t.integer :business_user_id
      t.integer :interview_room_id
      t.string :message

      t.timestamps
    end
  end
end
