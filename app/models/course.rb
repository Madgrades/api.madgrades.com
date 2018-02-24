class Course < ApplicationRecord
  self.primary_key = :uuid

  default_scope { order(number: :asc) }

  def subject_memberships
    SubjectMembership
        .joins('JOIN course_offerings ON course_offerings.uuid = subject_memberships.course_offering_uuid')
        .where('course_offerings.course_uuid = ?', uuid)
        .distinct
  end

  def subjects
    # todo: have a separate table for subjects
    subject_memberships.map(&:subject_code).uniq
  end

  def self.search(query)
    # todo?
    Course.joins('INNER JOIN course_offerings ON course_offerings.course_uuid = courses.uuid')
          .where('courses.number = ? OR course_offerings.name LIKE ?',
                 query, "%#{query}%")
          .distinct
  end

  def course_offerings
    CourseOffering.where(course_uuid: uuid)
  end

  def to_param
    uuid
  end
end
