# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_03_233244) do
  create_table "aplications", force: :cascade do |t|
    t.integer "candidate_id"
    t.integer "jobAdvirtesment_id"
    t.datetime "fechaAplicacion", precision: nil
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_aplications_on_candidate_id"
    t.index ["jobAdvirtesment_id"], name: "index_aplications_on_jobAdvirtesment_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "candidateName"
    t.string "candidateLastName"
    t.datetime "birthdate", precision: nil
    t.string "emial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "companyName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_advirtesments", force: :cascade do |t|
    t.integer "company_id"
    t.datetime "fechaPublicacion", precision: nil
    t.string "details"
    t.datetime "fechaCierre", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_advirtesments_on_company_id"
  end

end
