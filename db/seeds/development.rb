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
    cedula: '1',
    telefono: Faker::Number.number(10),
    email: 'taxituraadmin@gmail.com',
    direccion: 'Taxitura',
    token: 'tokentaxitura2017Abc',
    activo: true
  })
  u.save!
  u.be_admin
end

def create_assistant cedula
  u = User.new({
    nombre: "Asistente ##{cedula}",
    cedula: cedula,
    telefono: Faker::Number.number(10),
    email: Faker::Internet.email,
    direccion: Faker::Address.street_address,
    token: Faker::Crypto.md5,
    activo: true
  })
  u.save!
  u.be_assistant
end


def create_driver cedula 
  u = User.new({
    nombre: "Conductor ##{cedula}",
    cedula: cedula,
    telefono: Faker::Number.number(10),
    email: Faker::Internet.email,
    direccion: Faker::Address.street_address,
    token: Faker::Crypto.md5,
    activo: true
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

 pack8 = Package.create_with(
    nombre: "Paquete Bienvenida",
    cantidad_de_carreras: 35,
    valor_de_carrera: 0,
    utilidad_taxista: 100,
    valor_de_paquete: 0,
  ).find_or_create_by(nombre: 'Paquete Bienvenida')
 
end

User.delete_all
1.times { create_admin }
2.upto(15) {|iterator| create_driver iterator}
16.upto(21) {|iterator| create_assistant iterator}
1.times { create_packages } 
