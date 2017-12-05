class Recharge < ApplicationRecord
  belongs_to :user
  audited

  after_save do
    binding.pry
    new_credit = {
      credito: (self.user.credito + self.cantidad_de_carreras),
      credito_ganancia: (self.user.credito_ganancia + (self.ganancia_taxista / self.valor_de_carrera)) 
    }
    self.user.update(new_credit)
  end
end
