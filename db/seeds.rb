# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_admin
  u = User.new({
    nombre: 'Admin',
    cedula: '12345678',
    telefono: Faker::Number.number(10),
    email: 'taxituraadmin@gmail.com',
    direccion: Faker::Address.street_address,
    password: '12345678',
    token: Faker::Crypto.md5,
    activo: true
  })
  u.save!
  u.be_admin
end

def create_conductor
  u = User.new({
    nombre: 'Conductor de prueba',
    cedula: '123456789',
    telefono: Faker::Number.number(10),
    email: 'testconductor@gmail.com',
    direccion: Faker::Address.street_address,
    password: '123456789',
    token: Faker::Crypto.md5,
    activo: true
  })
  u.save!
  u.be_driver
end

def create_conductores
  u = User.new({
    nombre: Faker::Name.unique.name,
    cedula: Faker::Number.number(10),
    telefono: Faker::Number.number(10),
    email: Faker::Internet.email,
    direccion: Faker::Address.street_address,
    password: '123456',
    token: Faker::Crypto.md5,
    activo: Faker::Boolean.boolean
  })
  u.save!
  u.be_driver
end

def create_packages
  pack1 = Package.create_with(
    nombre: "Paquete #1",
    cantidad_de_carreras: 25,
    valor_de_carrera: 600,
    utilidad_taxista: 5,
    valor_de_paquete: 15000,
  ).find_or_create_by(nombre: 'Paquete #1')

  pack2 = Package.create_with(
    nombre: "Paquete #2",
    cantidad_de_carreras: 50,
    valor_de_carrera: 600,
    utilidad_taxista: 10,
    valor_de_paquete: 30000,
  ).find_or_create_by(nombre: 'Paquete #2')

  pack3 = Package.create_with(
    nombre: "Paquete #3",
    cantidad_de_carreras: 75,
    valor_de_carrera: 600,
    utilidad_taxista: 15,
    valor_de_paquete: 45000,
  ).find_or_create_by(nombre: 'Paquete #3')

  pack4 = Package.create_with(
    nombre: "Paquete #4",
    cantidad_de_carreras: 100,
    valor_de_carrera: 600,
    utilidad_taxista: 20,
    valor_de_paquete: 60000,
  ).find_or_create_by(nombre: 'Paquete #4')

  pack5 = Package.create_with(
    nombre: "Paquete #5",
    cantidad_de_carreras: 125,
    valor_de_carrera: 600,
    utilidad_taxista: 25,
    valor_de_paquete: 75000,
  ).find_or_create_by(nombre: 'Paquete #5')
 
 pack6 = Package.create_with(
    nombre: "Paquete #6",
    cantidad_de_carreras: 150,
    valor_de_carrera: 600,
    utilidad_taxista: 30,
    valor_de_paquete: 90000,
  ).find_or_create_by(nombre: 'Paquete #6')

 pack7 = Package.create_with(
    nombre: "Paquete #7",
    cantidad_de_carreras: 175,
    valor_de_carrera: 600,
    utilidad_taxista: 35,
    valor_de_paquete: 105000,
  ).find_or_create_by(nombre: 'Paquete #7')
 
end

User.delete_all
1.times { create_admin }
1.times { create_conductor }
8.times { create_conductores }
1.times { create_packages } 
