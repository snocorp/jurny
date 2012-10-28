class AddAdminToTravellers < ActiveRecord::Migration
  def change
    add_column :travellers, :admin, :boolean, {:default=>false}
    Traveller.update_all 'admin=false'
    change_column :travellers, :admin, :boolean, :null=>false
  end
end
