class TravellersController < ApplicationController
  # GET /travellers
  # GET /travellers.json
  def index
    if !signed_in? || !current_user.admin
      
      redirect_to root_path, notice: 'Permission denied'
    else
      @travellers = Traveller.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @travellers }
      end
    end
  end

  # GET /travellers/1
  # GET /travellers/1.json
  def show
    if !signed_in?
      redirect_to root_path, notice: 'You must be signed in to see your profile.'
    elsif !current_user.admin && params[:id] != current_user.id.to_s
      redirect_to current_user, notice: 'You can only see your own profile.'
    else
      @traveller = Traveller.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @traveller }
      end
    end
  end

  # GET /travellers/new
  def new
    @form_action = 'Create Traveller'
    
    if !signed_in? || !current_user.admin
      
      redirect_to root_path, notice: 'Permission denied'
    else
      @traveller = Traveller.new

      respond_to do |format|
        format.html # new.html.erb
      end
    end
  end

  # GET /travellers/1/edit
  def edit
    @form_action = 'Update'
    
    if signed_in? && (params[:id] == current_user.id.to_s || current_user.admin)
      @traveller = Traveller.find(params[:id])
    else
      redirect_to root_path, notice: 'Permission denied'
    end
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
        @traveller.email = params[:traveller][:email]
        @traveller.firstname = params[:traveller][:firstname]
        @traveller.lastname = params[:traveller][:lastname]
        
        if !(params[:traveller][:password].nil? && params[:traveller][:password_confirmation].nil?)
          #@traveller.password = params[:traveller][:password]
          #@traveller.password_confirmation = params[:traveller][:password_confirmation]
        end

        if @traveller.save
          sign_in @traveller
          format.html { redirect_to @traveller, notice: 'Updated successfully' }
        else
          format.html { render action: "edit", notice: @traveller.password }
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
end
