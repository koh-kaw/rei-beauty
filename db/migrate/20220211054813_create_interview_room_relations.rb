class CreateInterviewRoomRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :interview_room_relations do |t|
      t.integer :user_id
      t.integer :business_user_id
      t.integer :interview_room_id

      t.timestamps
    end
  end
end
