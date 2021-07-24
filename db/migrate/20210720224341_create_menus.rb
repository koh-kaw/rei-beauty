class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.bigint :owner_id
      t.string :name,  null: false
      t.string :place,  null: false
      t.string :price,  null: false
      t.datetime :start_at
      t.datetime :end_at
      t.text :content,  null: false
      t.string :image

      t.timestamps
    end

    add_index :menus, :owner_id
  end
end
