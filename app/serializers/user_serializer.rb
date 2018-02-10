class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :nombre,
             :cedula,
             :telefono,
             :email,
             :direccion,
             :password_digest,
             :token,
             :activo,
             :created_at,
             :updated_at,
             :foto,
             :credito,
             :credito_ganancia,
             :welcome,
             :taxis
end
