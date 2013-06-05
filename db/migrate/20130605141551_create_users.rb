class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :image
      t.integer :default_provider_id
      t.string :unconfirmed_email
      t.datetime :confirm_limit_at
      t.string :hash_to_confirm_email
      t.string :locale
      t.text :content

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end
    add_index :users, [:email], unique: true
  end
end
