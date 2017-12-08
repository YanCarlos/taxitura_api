class Taxi < ApplicationRecord
	# before_validation do
	#     raise CustomError, 'El modelo no puede contener letras.' unless is_number? self.modelo
	# end


 #  	private

	#   def is_number? value
	#     expression = /\A[-+]?[0-9]*\.?[0-9]+\Z/
	#     if expression.match(value)
	#       return true
	#     else
	#       return false
	#     end
	#   end
end