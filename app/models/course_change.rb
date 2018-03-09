class CourseChange < ApplicationRecord
  def course
    Course.find(course_uuid)
  end

  def self.populate!
    CourseChange.delete_all

    if CourseOfferingGradeDist.all.count === 0
      return false
    end

    queries = File.read("#{Rails.root}/lib/course_changes.sql").split(";")

    queries.each do |stmt|
      ActiveRecord::Base.connection.execute(stmt)
    end

    ActiveRecord::Base.connection.execute("INSERT INTO course_changes SELECT * FROM v_course_changes_all")
    ActiveRecord::Base.connection.execute("INSERT INTO course_changes SELECT * FROM v_course_changes_recent")
    true
  end
end
