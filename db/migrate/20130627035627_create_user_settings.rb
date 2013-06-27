class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id, null: false
      t.boolean :mail_attend_status, default: true, null: false
      t.boolean :mail_event_comment, default: true, null: false
      t.boolean :mail_event_attendance, default: true, null: false
      t.boolean :mail_group_event, default: true, null: false

      t.timestamps
    end
    add_index :user_settings, [:user_id], unique: true
  end
end
