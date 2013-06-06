class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :type
      t.integer :group_id, null: false
      t.integer :user_id, null: false
      t.text :content

      t.timestamps
    end
    add_index :posts, :group_id
  end
end
