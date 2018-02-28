class Subject < ApplicationRecord
  self.primary_key = :code

  default_scope { order(code: :asc) }

  def to_param
    code
  end

  def courses
    Course
      .joins('JOIN course_offerings ON course_offerings.course_uuid = courses.uuid')
      .joins('JOIN subject_memberships ON subject_memberships.course_offering_uuid = course_offerings.uuid')
      .where('subject_memberships.subject_code = ?', code)
      .distinct
  end
end
