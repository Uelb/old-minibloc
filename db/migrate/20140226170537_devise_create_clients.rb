class DeviseCreateClients < ActiveRecord::Migration
  def change
    create_table(:clients) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      #custom
      t.string :api_key
      t.string :name, :null => false
      t.string :event_base_url

      t.timestamps
    end

    add_index :clients, :email,                :unique => true
    add_index :clients, :reset_password_token, :unique => true
    add_index :clients, :api_key, :unique => true
    add_index :clients, :name, :unique => true
  end
end
