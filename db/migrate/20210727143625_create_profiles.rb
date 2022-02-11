class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :avatar
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
