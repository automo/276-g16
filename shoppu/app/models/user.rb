class User < ActiveRecord::Base
  has_many :order_owner, foreign_key: 'owner_id', class_name: "OrderRequest"
  has_many :order_servicer, foreign_key: 'servicer_id', class_name: "OrderRequest"

  before_save {username.downcase!}
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            length: {maximum:50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save {email.downcase!}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true



end
