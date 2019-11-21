class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :high_priority
      t.boolean :completed
      t.integer :category
      t.integer :user_id

      t.timestamps
    end
  end
end
