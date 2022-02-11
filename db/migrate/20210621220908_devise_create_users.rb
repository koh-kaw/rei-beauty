# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_i

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## SNS
      t.string :provider
      t.string :uid
      ## t.string :name, null: false
      t.string :token
      t.string :meta
      
      t.string :image
      t.string :id_front_image
      t.string :id_back_image
      t.boolean :id_cert,                     null: false, default: false


      t.string :identification

      t.string :name, null: false, default: "未設定"
      t.text :self_introduction, default: "よろしくお願いします。"
      t.date :birth
      t.integer :gender

      t.string :station
      t.integer :postal_code
      t.string :prefecture_code
      t.string :city
      t.string :street
      t.string :other_address
      t.integer :tel, unique: true 

      t.string :family_name
      t.string :first_name
      t.string :family_name_kana
      t.string :first_name_kana

      t.integer :station_id

      t.integer :ward_id

      t.timestamps null: false

      # Admin
      t.boolean :admin, default: false

      

    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    ##add_index :users, %i[provider uid],      unique: true
  end
end
