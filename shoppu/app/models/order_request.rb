class OrderRequest < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  validates :owner_id, presence: true

  belongs_to :owner, :class_name => "User"
  default_scope -> { order(created_at: :desc) }
  belongs_to :servicer, :class_name => "User"

end
