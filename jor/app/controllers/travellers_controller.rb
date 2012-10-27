class TravellersController < ApplicationController
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
  # GET /travellers/new.json
  def new
    @traveller = Traveller.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @traveller }
    end
  end

  # GET /travellers/1/edit
  def edit
    @traveller = Traveller.find(params[:id])
  end

  # POST /travellers
  # POST /travellers.json
  def create
    @traveller = Traveller.new(params[:traveller])

    respond_to do |format|
      if @traveller.save
        format.html { redirect_to root_path, notice: 'Success! Let your journey begin.' }
      else
        #hide any errors about the passowrd digest
	@traveller.errors.delete(:password_digest)

        format.html { render action: "signup" }
        format.json { render json: @traveller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /travellers/1
  # PUT /travellers/1.json
  def update
    @traveller = Traveller.find(params[:id])

    respond_to do |format|
      if @traveller.update_attributes(params[:traveller])
        format.html { redirect_to @traveller, notice: 'Traveller was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @traveller.errors, status: :unprocessable_entity }
      end
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
    @traveller = Traveller.new
    
    respond_to do |format|
      format.html # signup.html.erb
      format.json { render json: @traveller }
    end
  end
end
