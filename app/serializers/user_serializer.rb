class UserSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :cedula, :telefono, :email, :direccion, :activo, :created_at, :updated_at, :role
end
