class AddLongitudeToOrderRequests < ActiveRecord::Migration
  def change
    add_column :order_requests, :longitude, :float
  end
end
