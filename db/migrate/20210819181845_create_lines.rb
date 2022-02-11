class CreateLines < ActiveRecord::Migration[6.0]
    def change
        create_table :lines do |t|
            t.integer :line_id, null: false, unique: true
            t.integer :company_id
            t.string :name
            t.string :kana
            t.decimal :lat, :precision => 9, :scale => 6, null: true
            t.decimal :lng, :precision => 9, :scale => 6, null: true
 
            t.datetime :created_at
            t.datetime :updated_at
            t.datetime :deleted_at
        end
    end
end