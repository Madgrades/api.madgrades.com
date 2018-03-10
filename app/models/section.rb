class Section < ApplicationRecord
  self.primary_key = :uuid

  default_scope { order(number: :asc) }

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

  def room
    room_uuid == nil ? nil : Room.find(room_uuid)
  end

  def schedule
    schedule_uuid == nil ? nil : Schedule.find(schedule_uuid)
  end

  def instructors
    Instructor
        .joins('INNER JOIN teachings ON teachings.instructor_id = instructors.id')
        .where('teachings.section_uuid = ?', uuid)
        .distinct
  end
end
