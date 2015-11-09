class User < ActiveRecord::Base
  has_many :orders

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


  def age
  now = Time.now.utc.to_date
  now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  validates :age, numericality: {greater_than:0}
  validates :birthdate, presence: true




end
