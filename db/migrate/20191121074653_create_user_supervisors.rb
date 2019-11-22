class CreateUserSupervisors < ActiveRecord::Migration[5.2]
  def change
    create_table :user_supervisors do |t|
      t.integer :user_id
      t.integer :supervisor_id

      t.timestamps
    end
  end
end
