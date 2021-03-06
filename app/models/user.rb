# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  # Constant - starts with capital letter
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  # Removed presence: true because the password_digest will show the same error
  # message anyway.
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Not all databases use case-sensitive indexes so we'll make sure the 
  # email is saved in all lower case.
  # before_save { |user| user.email = user.email.downcase }
  # Nicer way
  before_save { email.downcase! }
  before_save :create_remember_token

  private 

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
