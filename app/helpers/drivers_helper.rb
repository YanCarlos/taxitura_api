module DriversHelper

  def self.get_driver_by_search q
    User.where("lower(nombre) LIKE '%#{q.downcase}%' OR telefono LIKE '%#{q}%' OR email LIKE '%#{q}%'").with_role :driver
  end

end