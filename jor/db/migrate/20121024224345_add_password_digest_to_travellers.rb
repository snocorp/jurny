class AddPasswordDigestToTravellers < ActiveRecord::Migration
  def change
    add_column :travellers, :password_digest, :string
  end
end
