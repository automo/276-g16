class CreateOrderRequests < ActiveRecord::Migration
  def change
    create_table :order_requests do |t|
      t.string :title, :null=>false
      t.decimal :bounty, :null=>false
      t.datetime :deliver_by
      t.datetime :accepted_at
      t.integer :service_rating, :default=>0
      t.string :status, :default=>"open", :null=>false
      t.references :owner, :null=>false, index: true, foreign_key: true
      t.references :servicer, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
  end
end
