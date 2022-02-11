class CreateBuserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :buser_profiles do |t|
      t.string :name
      t.string :avatar
      t.text :description
      t.integer :business_user_id

      t.timestamps
    end
  end
end
