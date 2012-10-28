class HomeController < ApplicationController
  def index
    if signed_in?
      render 'dashboard'
    end
  end
  
  def dashboard
    
  end
end
