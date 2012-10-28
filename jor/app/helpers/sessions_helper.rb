module SessionsHelper
  
  def sign_in(traveller)
    cookies.permanent[:remember_token] = traveller.remember_token
    self.current_user = traveller
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token);
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(traveller)
    @current_user = traveller
  end

  def current_user
    @current_user ||= Traveller.find_by_remember_token(cookies[:remember_token])
  end
end
