class User < ApplicationRecord
  rolify
  has_secure_password
  validates_presence_of :nombre, :email, :telefono, :direccion, :cedula, :password

  def be_admin
    self.add_role :admin
  end

  def be_assistant
    self.add_role :assistant
  end

  def be_driver
    self.add_role :driver
  end

  def reset_token
    self.update_attribute(:token, nil)
  end

  def generate_token(length=35)
    chars = 'abcde_fghjk_mnpqrs_tuvwxyzA_BCDEFGHJK_LMNP_QRSTUV_WXYZ012_3456789_'
    token = ''
    length.times { token << chars[rand(chars.size)] }
    self.update_attribute(:token, token)
  end
end
