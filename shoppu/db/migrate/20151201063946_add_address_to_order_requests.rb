class AddAddressToOrderRequests < ActiveRecord::Migration
  def change
    add_column :order_requests, :address, :string
  end
end
