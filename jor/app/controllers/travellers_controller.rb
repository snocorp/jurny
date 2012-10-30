class TravellersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :new, :edit, :update]
  before_filter :correct_user,   only: [:show, :edit, :update]
  before_filter :admin_user, only: [:index, :new]
  
  
  # GET /travellers
  # GET /travellers.json
  def index
    @travellers = Traveller.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @travellers }
    end
  end

  # GET /travellers/1
  # GET /travellers/1.json
  def show
    @traveller = Traveller.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @traveller }
    end
  end

  # GET /travellers/new
  def new
    @form_action = 'Create Traveller'
    
    @traveller = Traveller.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /travellers/1/edit
  def edit
    @form_action = 'Update'
    
    @traveller = Traveller.find(params[:id])
  end

  # POST /travellers
  # POST /travellers.json
  def create
    @traveller = Traveller.new(params[:traveller])
    
    if !signed_in?
      
      respond_to do |format|
        if @traveller.save
          sign_in @traveller
          format.html { redirect_to root_path, notice: 'Success! Let your journey begin.' }
        else
          #hide any errors about the password digest
          @traveller.errors.delete(:password_digest)

          format.html { render action: "signup" }
          format.json { render json: @traveller.errors, status: :unprocessable_entity }
        end
      end
    elsif current_user.admin
      
      respond_to do |format|
        if @traveller.save
          format.html { redirect_to root_path, notice: 'Success! Let your journey begin.' }
        else
          #hide any errors about the password digest
          @traveller.errors.delete(:password_digest)

          format.html { render action: "new" }
          format.json { render json: @traveller.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, notice: 'Permission denied'
    end
  end

  # PUT /travellers/1
  def update
    @traveller = Traveller.find(params[:id])

    if signed_in? && (@traveller.id == current_user.id || current_user.admin)
      respond_to do |format|
        if @traveller.update_attributes(params[:traveller])
          flash[:success] = "Profile updated"
          sign_in @traveller
          format.html { redirect_to @traveller }
        else
          format.html { render action: "edit" }
        end
      end
    else
      redirect_to root_path, notice: 'Permission denied'
    end
  end

  # DELETE /travellers/1
  # DELETE /travellers/1.json
  def destroy
    @traveller = Traveller.find(params[:id])
    @traveller.destroy

    respond_to do |format|
      format.html { redirect_to travellers_url }
      format.json { head :no_content }
    end
  end
  
  def signup
    @form_action = 'Sign Up'
    
    if !signed_in?
      @traveller = Traveller.new

      respond_to do |format|
        format.html # signup.html.erb
        format.json { render json: @traveller }
      end
    else
      redirect_to root_path, notice: 'You\'re already signed up.'
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
      redirect_to(root_path, notice: "Permission denied") unless current_user.admin
    end

    def correct_user
      @traveller = Traveller.find(params[:id])
      redirect_to(root_path, notice: "Permission denied") unless current_user?(@traveller) || current_user.admin
    end
end
