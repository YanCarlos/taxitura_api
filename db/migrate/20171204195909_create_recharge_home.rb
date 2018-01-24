class CreateRechargeHome < ActiveRecord::Migration[5.1]
  def change
    create_table :recharge_homes do |t|
      t.string :latitud
      t.string :longitud
      t.string :direccion
      t.string :nombre

      t.timestamps
    end
  end
end
