class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :status, :default=>"open"
      t.text :content
      t.references :order_request, :null=>false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
