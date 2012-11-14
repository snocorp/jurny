class TripsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:all]
  
  def index
    @trips = current_user.trips
  end
  
  def all
    @trips = Trip.all

    render 'index'
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = current_user.trips.new
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def create
    @trip = current_user.owned_trips.new(params[:trip])

    if @trip.save
      redirect_to @trip, notice: 'Trip was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @trip = Trip.find(params[:id])

    if @trip.update_attributes(params[:trip])
      redirect_to @trip, notice: 'Trip was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    
    if @trip.owner_id == current_user.id || current_user.admin?
      @trip.destroy

      if current_user.admin?
        redirect_to trips_all_url
      else
        redirect_to trips_url
      end
    else
      redirect_to root_path, notice: "Permission denied"
    end
  end
  
  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def admin_user
      redirect_to(root_path, notice: "Permission denied") unless current_user.admin?
    end
end
