class User < ApplicationRecord
  rolify
  has_many :recharges
  has_and_belongs_to_many :taxis
  audited
  has_secure_password
  mount_base64_uploader :foto, DriverPhotoUploader
  validates_presence_of :nombre, :email, :telefono, :direccion, :cedula

  before_validation do
    if self.new_record?
      self.password = self.cedula
      if self.foto.filename.nil?
        self.foto = ImagesUtils.avatar_profile
      end
    end
    raise CustomError, 'Ya hay un usuario registrado con este email.' if email_exists?
    raise CustomError, 'Ya hay un usuario registrado con esta cedula.' if cedula_exists?
  end


  # in this method we assigns taxis to user (type=taxi)
  def assign_taxi taxi
    CustomError.send('El usuario que intenta asignar con el taxi no es de tipo taxista.') unless self.has_role? :driver 
    CustomError.send('Este taxista no puede contener mas de 1 taxi asociado.') unless self.taxis.count < 1 
    CustomError.send('Este taxista ya tiene este taxi asociado.') if self.taxis.include? taxi
    self.taxis << taxi
  end

  
  def password_update params
    CustomError.send('La contraseña antigua no puede ser vacia.') if params[:contrasenia_antigua].nil?
    CustomError.send('Contraseña antigua incorrecta.') unless self.authenticate params[:contrasenia_antigua]
    CustomError.send('Las nuevas contraseñas no coinciden.') unless params[:contrasenia_nueva] == params[:confirmacion_contrasenia_nueva]
  end

  def be_admin
    self.add_role :admin
  end

  def be_assistant
    self.add_role :assistant
  end

  def be_driver
    self.add_role :driver
  end

  def email_exists?
    found = User.find_by(:email => self.email)
    found and  found!= self
  end

  def cedula_exists?
    found = User.find_by(:cedula => self.cedula)
    found and  found!= self
  end


  def reset_token
    reset_taxi
    self.update_attribute(:token, nil)
  end

  def reset_taxi
    if self.has_role? :driver
      taxi = self.taxis.first
      taxi.update_attribute(:ocupado, 'false')
      taxi.update_attribute(:ocupado_por, nil)
    end
  end

  def role
    self.roles[0].name
  end

  def generate_token(length=35)
    chars = 'abcde_fghjk_mnpqrs_tuvwxyzA_BCDEFGHJK_LMNP_QRSTUV_WXYZ012_3456789_'
    token = ''
    length.times { token << chars[rand(chars.size)] }
    self.update_attribute(:token, token)
  end

  def taxi_avalaible?
    taxi = self.taxis.first
    return false if taxi.nil?
    return false if taxi.ocupado? && taxi.ocupado_por != self.id 
    taxi.update_attribute(:ocupado, 'true')
    taxi.update_attribute(:ocupado_por, self.id)
    #CustomError.send('Necesita tener un taxi asignado.') unless 
    #CustomError.send('El taxi asignado se encuentra ocupado.') unless JSON.parse(self.taxis.to_json)[0]['ocupado'] != true
  end
end
