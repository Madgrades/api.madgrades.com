class DropTableCourseChange < ActiveRecord::Migration[5.1]
  def change
    drop_table :course_changes
  end
end
