class TripMembershipsController < ApplicationController
  def new
    @trips = Trip.all
  end

  def create
    current_user.trip_memberships.build(:trip_id => params[:trip])
    
    current_user.save
    
    redirect_to trip_add_path
  end

  def destroy
    
  end
end
