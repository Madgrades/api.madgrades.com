class CreateCourseChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :course_changes, id: false do |t|
      t.string :course_uuid
      t.decimal :count_change, precision: 10, scale: 6
      t.decimal :gpa_change, precision: 10, scale: 6
      t.string :duration
    end
  end
end
