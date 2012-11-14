class TravellersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :new, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  before_filter :admin_user, only: [:index, :new]
  
  def index
    @travellers = Traveller.all
  end

  def show
    @traveller = Traveller.find(params[:id])
  end

  # GET /travellers/new
  def new
    @form_action = 'Create Traveller'
    
    @traveller = Traveller.new
  end

  # GET /travellers/1/edit
  def edit
    @form_action = 'Update'
    
    @traveller = Traveller.find(params[:id])
  end
  
  def signup
    @form_action = 'Sign Up'
    
    if !signed_in?
      @traveller = Traveller.new
    else
      redirect_to root_path, notice: 'You\'re already signed up.'
    end
  end

  def create
    @traveller = Traveller.new(params[:traveller])
    
    if !signed_in?
      if @traveller.save
        sign_in @traveller
        redirect_to root_path, notice: 'Success! Let your journey begin.'
      else
        #hide any errors about the password digest
        @traveller.errors.delete(:password_digest)

        render action: "signup"
      end
    elsif current_user.admin?
      
      if @traveller.save
        redirect_to root_path, notice: 'Traveller created.'
      else
        #hide any errors about the password digest
        @traveller.errors.delete(:password_digest)

        render action: "new"
      end
    else
      redirect_to root_path, notice: 'Permission denied'
    end
  end

  # PUT /travellers/1
  def update
    @traveller = Traveller.find(params[:id])

    if signed_in? && (@traveller.id == current_user.id || current_user.admin?)
      @traveller.email = params[:traveller][:email]
      @traveller.firstname = params[:traveller][:firstname]
      @traveller.lastname = params[:traveller][:lastname]

      if current_user.admin? && !params[:traveller][:admin].nil?
        @traveller.admin = params[:traveller][:admin]
        params[:traveller].delete(:admin)
      end

      if @traveller.save
        flash[:success] = "Profile updated"
        sign_in @traveller
        redirect_to @traveller
      else
        render action: "edit"
      end
    else
      redirect_to root_path, notice: 'Permission denied'
    end
  end

  def destroy
    @traveller = Traveller.find(params[:id])
    
    if signed_in? && (@traveller.id == current_user.id || current_user.admin?)
      @traveller.destroy

      if @traveller.id == current_user.id
        sign_out
        redirect_to root_path
      else
        redirect_to travellers_url
      end
    else
      redirect_to root_path, notice: 'Permission denied'
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

    def correct_user
      @traveller = Traveller.find(params[:id])
      redirect_to(root_path, notice: "Permission denied") unless current_user?(@traveller) || current_user.admin?
    end
end
