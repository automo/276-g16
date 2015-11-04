class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :owner, :class_name => "User"
  belongs_to :servicer, :class_name => "User"
end
