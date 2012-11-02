class CreateTripMemberships < ActiveRecord::Migration
  def change
    create_table :trip_memberships do |t|
      t.integer :trip_id
      t.integer :traveller_id

      t.timestamps
    end
    add_index :trip_memberships, :trip_id
    add_index :trip_memberships, :traveller_id
  end
end
