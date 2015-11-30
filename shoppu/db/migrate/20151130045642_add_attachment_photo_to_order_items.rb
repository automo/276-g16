class AddAttachmentPhotoToOrderItems < ActiveRecord::Migration
  def self.up
    change_table :order_items do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :order_items, :photo
  end
end
