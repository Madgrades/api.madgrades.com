class CourseOfferingGradeDist < ApplicationRecord
  def self.populate!
    Rails.logger.info 'Populating course_offering_grade_dists...'

    grade_fields = GradeDistribution.grade_fields(true)
    sum_grade_fields = grade_fields.map{|field| "SUM(#{field}) AS #{field}"}.join(', ')

    CourseOfferingGradeDist.delete_all

    course_uuids = Course.select(:uuid).map(&:uuid)

    course_uuids.each do |uuid|

      select_stmt = GradeDistribution
                .select("courses.uuid AS course_uuid, course_offerings.term_code AS term_code, #{sum_grade_fields}")
                .joins('JOIN course_offerings ON grade_distributions.course_offering_uuid = course_offerings.uuid')
                .joins('JOIN courses ON course_offerings.course_uuid = courses.uuid')
                .group('course_offerings.term_code')
                .where('courses.uuid = ?', uuid)
                .distinct
                .to_sql

      # just let database insert batch, way faster than loading into memory
      insert_stmt = "INSERT INTO course_offering_grade_dists #{select_stmt}"

      ActiveRecord::Base.connection.execute(insert_stmt)
    end

    Rails.logger.info 'Done populating course_offering_grade_dists!'
  end
end
