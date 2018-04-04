class CreateInstructorGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :instructor_grades, id: false do |t|
      t.integer :instructor_id
      t.integer :gpa_total
      t.decimal :count_avg, precision: 6, scale: 3
      t.decimal :gpa, precision: 10, scale: 6
    end
  end
end
