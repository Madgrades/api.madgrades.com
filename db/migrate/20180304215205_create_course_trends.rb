class CreateCourseTrends < ActiveRecord::Migration[5.1]
  def change
    create_table :course_trends, id: false do |t|
      t.string :course_uuid
      t.integer :first_count
      t.integer :last_count
      t.decimal :first_gpa, precision: 5, scale: 4
      t.decimal :last_gpa, precision: 5, scale: 4
      t.integer :first_term
      t.integer :last_term
      t.string :duration
    end
  end
end
