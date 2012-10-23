class CreateTravellers < ActiveRecord::Migration
  def change
    create_table :travellers do |t|
      t.string :email
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
