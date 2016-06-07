class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.date :completion, null: false
      t.string :status, null: false
      t.integer :user_id, null: false
      t.string :kind, null: false

      t.index :title
      t.index :user_id
      t.timestamps null: false
    end
  end
end
