class UserSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :cedula, :foto, :telefono, :email, :direccion, :activo, :created_at, :updated_at, :role
end
