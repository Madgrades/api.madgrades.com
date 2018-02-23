class Section < ApplicationRecord
  self.primary_key = :uuid

  def to_param
    uuid
  end

  def term_name
    course_offering.term_name
  end

  def course_offering
    CourseOffering.find(course_offering_uuid)
  end

  def course
    course_offering.course
  end

  def schedule
    Schedule.find_by_uuid(schedule_uuid)
  end

  def instructors
    Teaching.where(section_uuid: uuid).map(&:instructor)
  end

  def grade_distribution
    GradeDistribution.where(course_offering_uuid: course_offering_uuid, section_number: number).first
  end
end
