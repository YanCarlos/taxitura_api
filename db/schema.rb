# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171208170230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "inboxes", force: :cascade do |t|
    t.string "nombre"
    t.string "email"
    t.string "asunto"
    t.string "mensaje"
  end

  create_table "packages", force: :cascade do |t|
    t.string "nombre"
    t.decimal "cantidad_de_carreras"
    t.decimal "valor_de_carrera"
    t.decimal "utilidad_taxista"
    t.decimal "valor_de_paquete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "ganancia_taxista"
  end

  create_table "questions", force: :cascade do |t|
    t.string "pregunta"
    t.string "respuesta"
    t.integer "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recharge_homes", force: :cascade do |t|
    t.string "latitud"
    t.string "longitud"
    t.string "direccion"
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recharges", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "cantidad_de_carreras"
    t.decimal "valor_de_carrera"
    t.decimal "utilidad_taxista"
    t.decimal "valor_de_paquete"
    t.decimal "ganancia_taxista"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "direccion"
    t.string "asistente_nombre"
    t.integer "asistente_id"
    t.string "nombre_paquete"
    t.index ["user_id"], name: "index_recharges_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
  end

  create_table "taxis", force: :cascade do |t|
    t.string "placa"
    t.integer "modelo"
    t.string "marca"
    t.string "nombre_propietario"
    t.string "telefono_propietario"
    t.boolean "baul"
    t.string "ciudad"
    t.boolean "activo"
    t.boolean "proxima_revision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxis_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "taxi_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre"
    t.string "cedula"
    t.string "telefono"
    t.string "email"
    t.string "direccion"
    t.string "password_digest"
    t.string "token"
    t.boolean "activo", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "foto"
    t.decimal "credito", default: "0.0"
    t.decimal "credito_ganancia", default: "0.0"
    t.index ["cedula"], name: "index_users_on_cedula", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
