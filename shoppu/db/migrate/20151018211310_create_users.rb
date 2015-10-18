class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.date :birthdate
      t.string :first_name
      t.string :last_name
      t.boolean :is_mod
      t.string :phone
      t.integer :rating
      t.integer :failed_login_attempts
      t.datetime :registered_at

      t.timestamps null: false
    end
  end
end
