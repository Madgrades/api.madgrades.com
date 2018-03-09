class DropCourseTrends < ActiveRecord::Migration[5.1]
  def change
    drop_table :course_trends
  end
end
