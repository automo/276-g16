class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :address, :null => false
      t.string :email, :null => false
      t.string :password, :null => false
      t.date :birthdate, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.boolean :is_mod, :default => false
      t.integer :rating, :default => 0
      t.integer :failed_login_attempts, :default => 0

      t.timestamps null: false
    end
  end
end
