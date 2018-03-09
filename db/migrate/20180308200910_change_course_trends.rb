class ChangeCourseTrends < ActiveRecord::Migration[5.1]
  def change
    remove_column :course_trends, :first_count
    remove_column :course_trends, :last_count
    remove_column :course_trends, :first_gpa
    remove_column :course_trends, :last_gpa
    remove_column :course_trends, :first_term
    remove_column :course_trends, :last_term
    remove_column :course_trends, :duration

    add_column :course_trends, :count_change, :decimal, precision: 5, scale: 4
    add_column :course_trends, :gpa_change, :decimal, precision: 5, scale: 4
  end
end
