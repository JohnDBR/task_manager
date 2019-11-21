class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :secret
      t.datetime :expire_at
      t.integer :user_id

      t.timestamps
    end

    add_index :tokens, :secret, unique: true
    add_index :tokens, :user_id
  end
end
