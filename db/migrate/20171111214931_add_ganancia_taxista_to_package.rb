class AddGananciaTaxistaToPackage < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :ganancia_taxista, :decimal
  end
end
