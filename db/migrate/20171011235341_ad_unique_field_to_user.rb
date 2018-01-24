class AdUniqueFieldToUser < ActiveRecord::Migration[5.1]
  def change
  	add_index :users, :cedula, unique: true
  	add_index :users, :email, unique: true
  end
end
