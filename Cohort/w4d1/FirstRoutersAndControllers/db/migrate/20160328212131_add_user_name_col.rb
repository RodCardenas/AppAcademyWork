class AddUserNameCol < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true

    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :user_id, null: false
      t.timestamp
    end

    add_index :contacts, [:email, :user_id], unique: true
    add_index :contacts, :user_id

    create_table :contact_shares do |t|
      t.integer :contact_id, null: false
      t.integer :user_id, null: false
      t.timestamp
    end

    add_index :contact_shares, :user_id
    add_index :contact_shares, :contact_id
  end
end
