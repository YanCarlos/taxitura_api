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

def create_assistant
  u = User.new({
    nombre: 'Assistant',
    cedula: '12345',
    telefono: Faker::Number.number(10),
    email: 'taxituraasistant@gmail.com',
    direccion: Faker::Address.street_address,
    password: '12345',
    token: Faker::Crypto.md5,
    activo: true
  })
  u.save!
  u.be_assistant
end

def create_service
  s = Service.create!({
    info: {
      "user": {
          "id": "1",
          "url_pic": "https://scontent.feoh3-1.fna.fbcdn.net/v/t1.0-9/24991563_1658185514201942_2418015399189639340_n.jpg?oh=43d1c5f9a928600d33a2a7ad70c7693d&oe=5AC175B5",
          "name": "Cristian Zapata",
          "first_name": "Cristian",
          "last_name": "Zapata"
      },
      "position_user": {
          "latitude": 4.4541073,
          "longitude": -75.7905437,
          "addressFull": "Cl. 13 #4c-1 a 4c-83, La Tebaida, El Brillante, La Tebaida, Quindío, Colombia",
          "address": "Cl. 13 #4c-1 a 4c-83,  La Tebaida"
      },
      "action": "aboard",
      "service": {
          "id": 1513376601239,
          "origin": "facebook",
          "date_creation": "2017-12-15T22:23:21.239Z"
      },
      "cabman": {
          "id": 102,
          "name": "Conductor de prueba",
          "photo": "http://www.taxitura.com/uploads/profile_photo/user/foto/12/foto.jpeg"
      },
      "position_cabman": {
          "distance": 652,
          "time": 195,
          "latitude": 4.45386772,
          "longitude": -75.78721474
      },
      "date": {      
        "creation": "2017-12-15T22:23:21.239Z", ### Fecha en la que el usuario crea el servicio - esto pasa en el bot
        "interface": "2017-12-15T22:23:15.239Z", ### Fecha en la que la interfaz crea e inicia a procesar el servicio
        "accept": "2017-12-15T21:16:00.239Z", ### fecha en la cual se acepta el servicio
        "arrive": "2017-12-15T22:23:21.239Z" , ### fecha en la cual el taxista indica que llego
        "aboard": "2017-12-15T22:23:21.239Z", ## fecha en la cual aborda el taxi el usuario
        "end": "2017-12-16T22:45:23.309Z", ### fecha en la que termina el servicio
        "cancel": "2017-12-15T22:23:21.239Z" ##E fecha en la cual se cancela el servicio en algun caso
     },
      "quality": {
         quality: {
           origin: 'facebook',
           value: "4",
           date: "02/05/34"
         },
         user: {
           id: "1"
         },
         service: {
           id: "1"
         }
       }
    }
  })
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
1.times { create_assistant }
1.times { create_conductor }
8.times { create_conductores }
1.times { create_packages } 
1.times { create_service }
