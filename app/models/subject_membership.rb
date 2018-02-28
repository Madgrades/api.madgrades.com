class SubjectMembership < ApplicationRecord
  default_scope { order(subject_code: :asc) }

  def subject
    Subject.find(subject_code)
  end

  def course_offering
    CourseOffering.find(course_offering_uuid)
  end
end
