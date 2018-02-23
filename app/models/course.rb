class Course < ApplicationRecord
  self.primary_key = :uuid

  default_scope { order(subject_code: :asc, number: :asc) }

  def self.search(query)
    # todo?
    Course.select('DISTINCT(courses.uuid), courses.subject_code, courses.number')
        .joins("INNER JOIN course_offerings ON course_offerings.course_uuid = courses.uuid")
        .where('short_name LIKE ?', "%#{query}%")
  end

  def name
    # todo
    course_offerings.first.name
  end

  def course_offerings
    CourseOffering.where(course_uuid: uuid)
  end

  def to_param
    uuid
  end
end
