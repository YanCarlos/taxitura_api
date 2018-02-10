class Service < ApplicationRecord
  before_save do
    self.info = JSON.parse self.info

    if !self.info['date']['end'].nil? && self.info['quality'].nil?
      taxista = User.find(self.info['cabman']['id'])
      if taxista['credito'] >= 1 || taxista['credito_ganancia'] == 0
        nuevo_credito = {credito: taxista['credito'] - 1}
      else
        nuevo_credito = {credito_ganancia: taxista['credito_ganancia'] - 1}
      end
      taxista.update!(nuevo_credito)
    end
  end
end
