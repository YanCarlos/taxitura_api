module TaxisHelper

  def self.get_taxi_by_search q
    Taxi.where("lower(placa) LIKE '%#{q.downcase}%' OR lower(marca) LIKE '%#{q.downcase}%' OR lower(nombre_propietario) LIKE '%#{q.downcase}%' OR lower(ciudad) LIKE '%#{q.downcase}%'")
  end

end