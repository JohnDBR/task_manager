class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :high_priority, default: false
      t.boolean :completed, default: false
      t.integer :category, default: 0
      t.integer :user_id

      t.timestamps
    end

    add_index :tasks, :name
    add_index :tasks, :user_id
  end
end
