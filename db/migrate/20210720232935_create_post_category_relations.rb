class CreatePostCategoryRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :post_category_relations do |t|
      t.references  :business_user,  index: true, foreign_key: true
      t.references  :post, index: true, foreign_key: true
      t.references  :category,  index: true, foreign_key: true

      t.timestamps
    end
  end
end
