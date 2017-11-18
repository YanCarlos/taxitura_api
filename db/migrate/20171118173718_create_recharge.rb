class CreateRecharge < ActiveRecord::Migration[5.1]
  def change
    create_table :recharges do |t|
      t.references :user
      t.decimal :cantidad_de_carreras
      t.decimal :valor_de_carrera
      t.decimal :utilidad_taxista
      t.decimal :valor_de_paquete
      t.decimal :ganancia_taxista

      t.timestamps
    end
  end
end
