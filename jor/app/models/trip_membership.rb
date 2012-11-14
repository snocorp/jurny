class TripMembership < ActiveRecord::Base
  attr_accessible :traveller_id, :trip_id
  belongs_to :traveller
  belongs_to :trip
  
  validates :traveller_id, presence: true
  validates :trip_id, presence: true
end
