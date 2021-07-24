class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.bigint :price
      t.string :state

      t.timestamps
    end
  end
end
