# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_user
  User.new({
    nombre: Faker::Name.unique.name,
    cedula: Faker::Number.number(10),
    telefono: Faker::Number.number(10),
    email: Faker::Internet.email,
    direccion: Faker::Address.street_address,
    password: '123456',
    token: Faker::Crypto.md5,
    activo: Faker::Boolean.boolean
  }).save!
end

User.delete_all
8.times { create_user }
