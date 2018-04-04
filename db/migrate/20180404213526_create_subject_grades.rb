class CreateSubjectGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :subject_grades, id: false do |t|
      t.string :subject_code
      t.integer :gpa_total
      t.decimal :count_avg, precision: 6, scale: 3
      t.decimal :gpa, precision: 10, scale: 6
    end
  end
end
