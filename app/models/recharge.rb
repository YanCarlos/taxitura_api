class Recharge < ApplicationRecord
  belongs_to :user
  audited

  after_save do
    new_credit = {
      credito: (self.user.credito + self.cantidad_de_carreras),
      credito_ganancia: (self.user.credito_ganancia + (self.ganancia_taxista / self.valor_de_carrera)) 
    }
    self.user.update(new_credit)
  end

  before_save do
  	puts self.to_json
  	if self.utilidad_taxista == 100 && self.valor_de_carrera == 0
  		driver = User.find(self.user.id)
  		if !driver['welcome']
  			self.user.update({welcome: true})
  		else
  			CustomError.send('Anteriormente se asigno el paquete de bienvenida a este taxista.')
  		end
  	end
  end
end
