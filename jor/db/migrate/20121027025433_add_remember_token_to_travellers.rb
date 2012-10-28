class AddRememberTokenToTravellers < ActiveRecord::Migration
  def change
    add_column :travellers, :remember_token, :string
    add_index  :travellers, :remember_token
    
    Traveller.all.each { |user| user.save(validate: false) }
  end
end
