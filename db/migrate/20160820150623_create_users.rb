class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
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
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.string      :gender
      t.string      :first_name
      t.string      :last_name
      t.string      :phone
      t.date        :birthday

      ## Imgage (handled via dragonfly)
      t.string      :image_uid
      t.string      :image_name
      t.string      :image_crop

      ## Admin - Atts
      t.boolean     :is_wizard,             default: false
      t.boolean     :is_master_wizard,      default: false
      t.boolean     :tmp_password

      ## User - Tracking
      t.string      :signup_via     # => "app" | "facebook" | "google" | ..
      t.string      :signup_url     # => which url, to track landing pages

      
      ## API -Auth
      t.string      :api_auth_token

      t.timestamps
    end

    add_index :users, :email,                 unique: true
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :reset_password_token,  unique: true
    add_index :users, :confirmation_token,    unique: true
    add_index :users, :unlock_token,          unique: true
    add_index :users, :api_auth_token,        unique: true
    
  end
end
