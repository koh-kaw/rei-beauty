class CreateBusinessUserTreatmentAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :business_user_treatment_areas do |t|
      t.integer :ward_id
      t.references  :business_user, foreign_key: true
      t.timestamps
    end
  end
end
