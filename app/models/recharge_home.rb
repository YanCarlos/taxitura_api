class RechargeHome < ApplicationRecord

  before_validation do
    raise CustomError, 'La Latitud no puede contener letras.' unless is_number? self.latitud
    raise CustomError, 'La Longitud no puede contener letras.' unless is_number? self.longitud
  end


  private
  def is_number? value
    expression = /\A[-+]?[0-9]*\.?[0-9]+\Z/
    if expression.match(value)
      return true
    else
      return false
    end
  end

end
