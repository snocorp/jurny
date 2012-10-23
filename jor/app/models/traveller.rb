class Traveller < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password
end
