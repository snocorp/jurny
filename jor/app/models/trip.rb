class Trip < ActiveRecord::Base
  attr_accessible :name, :summary
  
  belongs_to :owner, :class_name => 'Traveller', :foreign_key => 'owner_id'
  
  validates :name, presence: true
  validates :owner, presence: true
end
