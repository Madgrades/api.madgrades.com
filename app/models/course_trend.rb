class CourseTrend < ApplicationRecord
  def course
    Course.find(course_uuid)
  end

  def self.populate!
    CourseTrend.delete_all

    if CourseOfferingGradeDist.all.count === 0
      return false
    end

    trends_all = File.read("#{Rails.root}/lib/trends_all.sql")
    trends_recent = File.read("#{Rails.root}/lib/trends_recent.sql")

    ActiveRecord::Base.connection.execute("INSERT INTO course_trends #{trends_all}")
    ActiveRecord::Base.connection.execute("INSERT INTO course_trends #{trends_recent}")
    true
  end
end
