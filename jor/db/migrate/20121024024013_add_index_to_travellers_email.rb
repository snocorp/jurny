class AddIndexToTravellersEmail < ActiveRecord::Migration
  def change
    add_index :travellers, :email, unique: true
  end
end
