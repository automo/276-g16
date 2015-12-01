class OrderRequest < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items
  validates :owner_id, presence: true

  validates :bounty, presence: true,
                     numericality: { :greater_than_or_equal_to => 0 }

  belongs_to :owner, :class_name => "User"
  default_scope -> { order(created_at: :desc) }
  belongs_to :servicer, :class_name => "User"

  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode

end
