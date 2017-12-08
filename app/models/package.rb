class Package < ApplicationRecord
  audited
  before_validation do 
    self.ganancia_taxista = self.valor_de_paquete * (self.utilidad_taxista/100)
  end
end
