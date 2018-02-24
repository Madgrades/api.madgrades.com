class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :courses, :uuid, unique: true

    add_index :course_offerings, :uuid, unique: true
    add_index :course_offerings, :course_uuid

    add_index :grade_distributions, :course_offering_uuid

    add_index :instructors, :id, unique: true

    add_index :rooms, :uuid, unique: true

    add_index :schedules, :uuid, unique: true

    add_index :sections, :uuid, unique: true
    add_index :sections, :course_offering_uuid

    add_index :teachings, :section_uuid
    add_index :teachings, :instructor_id
  end
end
