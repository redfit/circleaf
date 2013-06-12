class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :content
      t.string :scope, null: false, default: 'public'

      t.timestamps
    end
    add_index :groups, [:scope]
  end
end
