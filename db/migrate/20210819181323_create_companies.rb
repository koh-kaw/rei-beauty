class CreateCompanies < ActiveRecord::Migration[6.0]
    def change
        create_table :companies do |t|
            t.integer :company_id, null: false, unique: true
            t.string :name
            t.string :kana
            t.string :formal_name
            t.string :abbreviation_name
 
            t.datetime :created_at
            t.datetime :updated_at
            t.datetime :deleted_at
        end
    end
end