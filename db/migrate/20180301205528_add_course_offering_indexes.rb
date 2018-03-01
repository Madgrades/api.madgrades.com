class AddCourseOfferingIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :course_offering_grade_dists, [:course_uuid, :term_code], :unique => true
  end
end
