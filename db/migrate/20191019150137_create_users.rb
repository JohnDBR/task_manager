class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :middlename
      t.string :lastname
      t.date :birthdate
      t.integer :gender
      t.string :email
      t.string :supervisor_email # empanadita!
      t.string :password_digest
      t.integer :role, default: 0

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
