class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :status, null: false, default: 'attend'

      t.timestamps
    end
    add_index :attendances, [:event_id, :user_id], unique: true
  end
end
