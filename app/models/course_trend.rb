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

  def growth_trend
    (last_count - first_count).to_f / (last_term - first_term).to_f
  end

  def gpa_trend
    (last_gpa.to_f - first_gpa.to_f) / (last_term - first_term).to_f
  end

  def growth_trend_score
    (1.5 * growth_trend).round(2)
  end

  def gpa_trend_score
    (1000.0 * gpa_trend).round(2)
  end
end
