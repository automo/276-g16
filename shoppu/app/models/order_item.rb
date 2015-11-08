class OrderItem < ActiveRecord::Base
  belongs_to :order_request

  def completed?
    !completed_at.blank?
  end
end
