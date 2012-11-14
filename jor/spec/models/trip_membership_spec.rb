require 'spec_helper'

describe TripMembership do
  let (:trip_membership) { TripMembership.new(:trip_id => 1, :traveller_id=>2) }
  
  subject { trip_membership }
  
  it { should respond_to(:trip_id) }
  it { should respond_to(:traveller_id) }
  
  describe "when trip_id is not present" do
    before { trip_membership.trip_id = nil }
    it { should_not be_valid }
  end
  
  describe "when traveller_id is not present" do
    before { trip_membership.traveller_id = nil }
    it { should_not be_valid }
  end
end
