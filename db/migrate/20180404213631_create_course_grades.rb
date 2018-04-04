class CreateCourseGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :course_grades, id: false do |t|
      t.string :course_uuid
      t.integer :gpa_total
      t.decimal :count_avg, precision: 6, scale: 3
      t.decimal :gpa, precision: 6, scale: 3
    end
  end
end
