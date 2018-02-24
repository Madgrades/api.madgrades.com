json.partial! "course_offerings/course_offering", course_offering: @course_offering
json.grades_url course_offering_grades_url(@course_offering.id)
json.subjects @course_offering.subjects
json.course_url course_url(@course_offering.course_uuid)
json.sections @course_offering.sections.each do |section|
  json.partial! "sections/section", section: section
end
