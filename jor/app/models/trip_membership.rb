class TripMembership < ActiveRecord::Base
  attr_accessible :traveller_id, :trip_id
  belongs_to :traveller
  belongs_to :trip
end
