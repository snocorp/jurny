require 'spec_helper'

describe Trip do
  let(:traveller) { FactoryGirl.create(:traveller) }
  before do
    @trip = traveller.owned_trips.new(name: "Eurotrip", summary: "Travelling to europe!")
  end
  
  subject { @trip }
  
  it { should respond_to(:name) }
  it { should respond_to(:summary) }
  it { should respond_to(:owner) }
  it { should respond_to(:trip_memberships) }
  it { should respond_to(:travellers) }
  
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to owner_id" do
      expect do
        Trip.new(owner_id: traveller.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when owner_id is not present" do
    before { @trip.owner_id = nil }
    it { should_not be_valid }
  end
  
  describe "when a trip is destroyed" do
    before { @trip.destroy }
    it "should not have any trip memberships" do
      pending "figure out how to test this"
    end
  end
end
