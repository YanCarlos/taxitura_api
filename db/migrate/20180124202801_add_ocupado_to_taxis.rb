class AddOcupadoToTaxis < ActiveRecord::Migration[5.1]
  def change
    add_column :taxis, :ocupado, :boolean
  end
end
