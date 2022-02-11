class CreateInterviewRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :interview_rooms do |t|

      t.timestamps
    end
  end
end
