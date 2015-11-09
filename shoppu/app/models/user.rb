class User < ActiveRecord::Base
  has_many :orders
  has_many :owned_orders, foreign_key: 'owner_id', class_name: "OrderRequest", dependent: :destroy
  has_many :serviced_orders, foreign_key: 'servicer_id', class_name: "OrderRequest", dependent: :destroy

  attr_accessor :remember_token, :reset_token

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

  validates :age, numericality: {greater_than:0}
  validates :birthdate, presence: true

  def age
  now = Time.now.utc.to_date
  now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sets the password reset attributes.
    def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest,  User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end


  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

end
