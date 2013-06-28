class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :group_id
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :content
      t.text :summary
      t.text :place_url
      t.string :place_name
      t.string :place_address
      t.string :place_map_url
      t.integer :capacity_min
      t.integer :capacity_max
      t.datetime :begin_at
      t.datetime :end_at
      t.datetime :receive_begin_at
      t.datetime :receive_end_at
      t.timestamps
    end
    add_index :events, [:group_id]
  end
end
