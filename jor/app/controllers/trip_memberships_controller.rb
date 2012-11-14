class TripMembershipsController < ApplicationController
  before_filter :correct_user,   only: [:destroy]
  
  def new
    @trips = Trip.all
  end

  def create
    current_user.trip_memberships.build(:trip_id => params[:trip])
    
    current_user.save
    
    redirect_to trip_path params[:trip]
  end

  def destroy
    @trip_membership = TripMembership.find(params[:id])
    
    @trip_membership.destroy
  end
  
  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @trip_membership = TripMembership.find(params[:id])
      
      redirect_to(root_path, notice: "Permission denied") unless current_user?(@trip_membership.traveller) || current_user.admin?
    end
end
