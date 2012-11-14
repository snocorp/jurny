class Traveller < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation
  
  # trips that were created by this traveller
  has_many :owned_trips, :class_name => 'Trip', :foreign_key => 'owner_id'
  
  # trips the traveller is going on
  has_many :trip_memberships
  has_many :trips, :through => :trip_memberships
  
  has_secure_password
  
  #ensure the email is saved in lowercase
  before_save { |traveller| traveller.email = email.downcase }
  
  #create a token for the traveller
  before_save :create_remember_token
  
  #ensure the email is present, has a valid format and is unique
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  #validate the password is at least six characters on creation
  validates :password, length: { minimum: 6 }, :on => :create
  
  #validates the password confirmation is present on creation
  validates :password_confirmation, presence: true, :on => :create
  
  # returns the full name of the user
  def fullname
    self.firstname+' '+self.lastname
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
