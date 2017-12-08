class CreateTaxi < ActiveRecord::Migration[5.1]
  def change
    create_table :taxis do |t|
      t.string :placa
      t.integer :modelo
      t.string :marca
      t.string :nombre_propietario
      t.string :telefono_propietario
      t.boolean :baul
      t.string :ciudad
      t.boolean :activo
      t.boolean :proxima_revision
      t.timestamps
    end
  end
end
