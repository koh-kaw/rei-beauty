class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :category_id, null: false
      t.integer :price, null: false
      t.string :image
      t.integer :buser_id
      t.integer :time, null: false
      
      t.timestamps
    end
  end
end
