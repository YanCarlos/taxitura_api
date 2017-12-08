class AddFieldsToRecharge < ActiveRecord::Migration[5.1]
  def change
    add_column :recharges, :direccion, :string
    add_column :recharges, :asistente_nombre, :string
    add_column :recharges, :asistente_id, :integer
  end
end
