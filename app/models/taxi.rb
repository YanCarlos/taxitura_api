class Taxi < ApplicationRecord
  has_and_belongs_to_many :users
  before_validation :rules
  scope :modelo_filter, ->(modelo) { where('modelo like ?', "#{modelo}%") }



  def es_ocupado_por? driver
    ocupado_por == driver.id
  end

  def logout driver_id
    update_attributes(ocupado: false) &&  update_attributes(ocupado_por: nil) && User.find(driver_id).update_attributes(token: nil)
  end

  
  private
  def self.ransackable_scopes(auth_object = nil)
    %i(modelo_filter)
  end

  def rules
    errors.add(:placa, 'La placa ya existe.') if placa_exists?
  end

  def placa_exists? 
    taxi = Taxi.find_by(placa: self.placa) 
    return true if taxi.present? && taxi.id != self.id
  end



end
