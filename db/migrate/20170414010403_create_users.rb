class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :salt

      t.string :first_name
      t.string :last_name
      t.integer :title
      t.integer :gender
      t.integer :status

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end
end
