class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password_digest, null: false
      t.string :session_token, null: false

      t.index :password_digest
      t.index :session_token
      t.timestamps null: false
    end
  end
end
