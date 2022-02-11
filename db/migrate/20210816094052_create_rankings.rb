class CreateRankings < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.references :business_user, null: false, foreign_key: true
      t.float :score
      t.integer :category_id

      t.timestamps
    end
  end
end
