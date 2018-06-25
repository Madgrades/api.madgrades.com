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

ActiveRecord::Schema.define(version: 20180625194343) do

  create_table "course_grades", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "course_uuid"
    t.integer "gpa_total"
    t.decimal "count_avg", precision: 6, scale: 3
    t.decimal "gpa", precision: 6, scale: 3
  end

  create_table "course_offering_grade_dists", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "course_uuid"
    t.integer "term_code"
    t.integer "a_count"
    t.integer "ab_count"
    t.integer "b_count"
    t.integer "bc_count"
    t.integer "c_count"
    t.integer "d_count"
    t.integer "f_count"
    t.integer "s_count"
    t.integer "u_count"
    t.integer "cr_count"
    t.integer "n_count"
    t.integer "p_count"
    t.integer "i_count"
    t.integer "nw_count"
    t.integer "nr_count"
    t.integer "other_count"
    t.index ["course_uuid", "term_code"], name: "index_course_offering_grade_dists_on_course_uuid_and_term_code", unique: true
    t.index ["course_uuid"], name: "index_course_offering_grade_dists_on_course_uuid"
    t.index ["term_code"], name: "index_course_offering_grade_dists_on_term_code"
  end

  create_table "course_offerings", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uuid"
    t.string "course_uuid"
    t.integer "term_code"
    t.string "name"
    t.index ["course_uuid"], name: "index_course_offerings_on_course_uuid"
    t.index ["term_code"], name: "index_course_offerings_on_term_code"
    t.index ["uuid"], name: "index_course_offerings_on_uuid", unique: true
  end

  create_table "courses", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uuid"
    t.integer "number"
    t.string "name"
    t.index ["uuid"], name: "index_courses_on_uuid", unique: true
  end

  create_table "grade_distributions", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "course_offering_uuid"
    t.integer "section_number"
    t.integer "a_count"
    t.integer "ab_count"
    t.integer "b_count"
    t.integer "bc_count"
    t.integer "c_count"
    t.integer "d_count"
    t.integer "f_count"
    t.integer "s_count"
    t.integer "u_count"
    t.integer "cr_count"
    t.integer "n_count"
    t.integer "p_count"
    t.integer "i_count"
    t.integer "nw_count"
    t.integer "nr_count"
    t.integer "other_count"
    t.decimal "gpa", precision: 7, scale: 5
    t.index ["course_offering_uuid"], name: "index_grade_distributions_on_course_offering_uuid"
    t.index ["section_number"], name: "index_grade_distributions_on_section_number"
  end

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "instructor_grade_dists", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "course_uuid"
    t.integer "instructor_id"
    t.integer "term_code"
    t.integer "a_count"
    t.integer "ab_count"
    t.integer "b_count"
    t.integer "bc_count"
    t.integer "c_count"
    t.integer "d_count"
    t.integer "f_count"
    t.integer "s_count"
    t.integer "u_count"
    t.integer "cr_count"
    t.integer "n_count"
    t.integer "p_count"
    t.integer "i_count"
    t.integer "nw_count"
    t.integer "nr_count"
    t.integer "other_count"
    t.index ["course_uuid"], name: "index_instructor_grade_dists_on_course_uuid"
    t.index ["instructor_id"], name: "index_instructor_grade_dists_on_instructor_id"
    t.index ["term_code"], name: "index_instructor_grade_dists_on_term_code"
  end

  create_table "instructor_grades", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "instructor_id"
    t.integer "gpa_total"
    t.decimal "count_avg", precision: 6, scale: 3
    t.decimal "gpa", precision: 10, scale: 6
  end

  create_table "instructors", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id"
    t.string "name"
    t.index ["id"], name: "index_instructors_on_id", unique: true
  end

  create_table "rooms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uuid"
    t.string "facility_code"
    t.string "room_code"
    t.index ["uuid"], name: "index_rooms_on_uuid", unique: true
  end

  create_table "schedules", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uuid"
    t.integer "start_time"
    t.integer "end_time"
    t.boolean "mon"
    t.boolean "tues"
    t.boolean "wed"
    t.boolean "thurs"
    t.boolean "fri"
    t.boolean "sat"
    t.boolean "sun"
    t.index ["uuid"], name: "index_schedules_on_uuid", unique: true
  end

  create_table "sections", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "uuid"
    t.string "course_offering_uuid"
    t.string "section_type"
    t.integer "number"
    t.string "room_uuid"
    t.string "schedule_uuid"
    t.index ["course_offering_uuid"], name: "index_sections_on_course_offering_uuid"
    t.index ["number"], name: "index_sections_on_number"
    t.index ["uuid"], name: "index_sections_on_uuid", unique: true
  end

  create_table "subject_grades", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "subject_code"
    t.integer "gpa_total"
    t.decimal "count_avg", precision: 6, scale: 3
    t.decimal "gpa", precision: 10, scale: 6
  end

  create_table "subject_memberships", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "subject_code"
    t.string "course_offering_uuid"
    t.index ["course_offering_uuid"], name: "index_subject_memberships_on_course_offering_uuid"
    t.index ["subject_code"], name: "index_subject_memberships_on_subject_code"
  end

  create_table "subjects", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name"
    t.string "abbreviation"
    t.index ["code"], name: "index_subjects_on_code", unique: true
    t.index ["name"], name: "index_subjects_on_name"
  end

  create_table "teachings", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "section_uuid"
    t.integer "instructor_id"
    t.index ["instructor_id"], name: "index_teachings_on_instructor_id"
    t.index ["section_uuid"], name: "index_teachings_on_section_uuid"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_token"
  end

  add_foreign_key "identities", "users"
end
