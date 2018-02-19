def create_admin
  u = User.new({
    nombre: 'Admin',
    cedula: '12345678',
    telefono: Faker::Number.number(10),
    email: 'taxituraadmin@gmail.com',
    direccion: 'Taxitura',
    password: '@12345Abc',
    token: 'tokentaxitura2017Abc',
    activo: true
  })
  u.save!
  u.be_admin
end

User.delete_all
1.times { create_admin }
