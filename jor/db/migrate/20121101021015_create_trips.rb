class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.text :summary
      t.integer :owner_id

      t.timestamps
    end
    add_index :trips, :owner_id
  end
end
