class InstructorGrade < ApplicationRecord
  def self.repopulate!
    InstructorGrade.delete_all
    query = File.read("#{Rails.root}/lib/populate_instructor_grades.sql")
    ActiveRecord::Base.connection.execute("INSERT INTO instructor_grades #{query}")
    true
  end

  def instructor
    Instructor.find(instructor_id)
  end
end
