class Teaching < ApplicationRecord
  def section
    Section.find(section_uuid)
  end

  def instructor
    Instructor.find(instructor_id)
  end
end
