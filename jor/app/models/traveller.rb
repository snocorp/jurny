class Traveller < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation
  has_many :owned_trips, :class_name => 'Trip', :foreign_key => 'owner_id'
  has_many :trip_memberships
  has_many :trips, :through => :trip_memberships
  
  has_secure_password
  
  before_save { |traveller| traveller.email = email.downcase }
  before_save :create_remember_token
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  
  def fullname
    self.firstname+' '+self.lastname
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
