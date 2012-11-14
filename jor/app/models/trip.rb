class Trip < ActiveRecord::Base
  attr_accessible :name, :summary
  
  belongs_to :owner, :class_name => 'Traveller', :foreign_key => 'owner_id'
  has_many :trip_memberships
  has_many :travellers, :through => :trip_memberships
  
  validates :name, presence: true
  validates :owner_id, presence: true
end
