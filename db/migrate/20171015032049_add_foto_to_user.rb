class AddFotoToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :foto, :string
  end
end
