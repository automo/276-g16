class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null=>false
      t.string :address, :null=>false
      t.string :email, :null=>false
      t.string :password_digest, :null=>false
      t.date :birthdate, :null=>false
      t.string :first_name, :null=>false
      t.string :last_name, :null=>false
      t.boolean :is_moderator, :default=>false, :null=>false
      t.integer :rating, :default=>0, :null=>false
      t.integer :failed_login_attempts, :default=>0, :null=>false

      t.timestamps null: false
    end
  end
end
