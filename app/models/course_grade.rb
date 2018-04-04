class CourseGrade < ApplicationRecord
  def self.repopulate!
    CourseGrade.delete_all
    query = File.read("#{Rails.root}/lib/populate_course_grades.sql")
    ActiveRecord::Base.connection.execute("INSERT INTO course_grades #{query}")
    true
  end

  def course
    Course.find(course_uuid)
  end
end
