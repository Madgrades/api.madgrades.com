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
    Room.find(room_uuid)
  end

  def schedule
    Schedule.find(schedule_uuid)
  end

  def instructors
    Instructor.select('instructors.*')
              .joins('INNER JOIN teachings ON teachings.instructor_id = instructors.id')
              .where('teachings.section_uuid = ?', uuid)
  end
end
