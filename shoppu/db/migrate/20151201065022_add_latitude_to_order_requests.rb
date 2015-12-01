class AddLatitudeToOrderRequests < ActiveRecord::Migration
  def change
    add_column :order_requests, :latitude, :float
  end
end
