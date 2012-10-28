class SessionsController < ApplicationController
  def new
  end

  def create
    traveller = Traveller.find_by_email(params[:session][:email].downcase)
    if traveller && traveller.authenticate(params[:session][:password])
      sign_in traveller
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
