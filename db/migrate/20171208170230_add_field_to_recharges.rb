class AddFieldToRecharges < ActiveRecord::Migration[5.1]
  def change
    add_column :recharges, :nombre_paquete, :string
  end
end
