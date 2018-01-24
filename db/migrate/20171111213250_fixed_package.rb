class FixedPackage < ActiveRecord::Migration[5.1]
  def change
    rename_column(:packages, :cantidad, :cantidad_de_carreras)
    rename_column(:packages, :valor, :valor_de_carrera)
    rename_column(:packages, :porcentaje_aumento, :utilidad_taxista) 
    rename_column(:packages, :carreras_aumento, :valor_de_paquete) 
  end
end
