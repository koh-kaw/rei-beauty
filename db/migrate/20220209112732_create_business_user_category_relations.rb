class CreateBusinessUserCategoryRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :business_user_category_relations do |t|
      t.references  :business_user, foreign_key: true
      t.references  :category, foreign_key: true
      t.timestamps
    end
  end
end
