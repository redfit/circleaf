class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
      t.string :level, null: false, default: 'member'

      t.timestamps
    end
    add_index :memberships, [:group_id, :user_id], unique: true
  end
end
