class CreatePackage < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.string :nombre
      t.decimal :cantidad
      t.decimal :valor
      t.decimal :porcentaje_aumento
      t.decimal :carreras_aumento
    
      t.timestamps
    end
  end
end
