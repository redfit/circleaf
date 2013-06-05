class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name, null: false
      t.string :image
      t.string :access_token, null: false
      t.string :secret_token

      t.timestamps
    end
    add_index :connections, [:user_id]
    add_index :connections, [:provider, :uid], unique: true
  end
end
