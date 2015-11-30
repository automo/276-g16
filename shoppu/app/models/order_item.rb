class OrderItem < ActiveRecord::Base
  belongs_to :order_request

  has_attached_file :photo,
                    :styles => { :small => "150x150>" },
                    :storage => :s3,
                    :s3_region => ENV['S3_REGION'],
                    :bucket => ENV['S3_BUCKET_NAME'],
                    :endpoint => ENV['AWS_ENDPOINT'],
                    :s3_permissions => ENV['S3_PERMS']

  validates_attachment_size :photo, :less_than => 3.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def completed?
    !completed_at.blank?
  end
end
