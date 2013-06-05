class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :image
      t.integer :default_provider_id
      t.string :unconfirmed_email
      t.datetime :confirm_limit_at
      t.string :hash_to_confirm_email
      t.string :locale
      t.text :content

      t.timestamps
    end
    add_index :users, [:email], unique: true
  end
end
