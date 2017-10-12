class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :cedula
      t.string :telefono
      t.string :email
      t.string :direccion 
      t.string :password_digest, :default => nil
      t.string :token, :default => nil
      t.boolean :activo, :default => false

      t.timestamps
    end
  end
end
