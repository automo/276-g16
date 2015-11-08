class AddCompletedAtToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :completed_at, :datetime
  end
end
