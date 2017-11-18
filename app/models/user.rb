class User < ApplicationRecord
  rolify
  has_many :recharges
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

  
  def password_update params
    CustomerError.send('La contrasenia antigua no puede ser vacia.') if params[:contrasenia_antigua].nil?
    CustomError.send('Contraseña antigua incorrecta.') unless self.authenticate params[:contrasenia_antigua]
    CustomError.send('Las nuevas contraseñas no coinciden.') unless params[:contrasenia_nueva] == params[:confirmacion_contrasenia_nueva]
    self.update_attribute('password', params[:contrasenia_nueva])
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
    self.update_attribute(:token, nil)
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
end
