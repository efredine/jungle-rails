class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  before_save :normalize_email

  validates :first_name, :last_name, :email, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 8 }, allow_nil: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  private

    def normalize_email
      self.email.strip!
      self.email.downcase!
    end

end
