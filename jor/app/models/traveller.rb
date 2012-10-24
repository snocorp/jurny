class Traveller < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation
  has_secure_password
  
  before_save { |traveller| traveller.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
