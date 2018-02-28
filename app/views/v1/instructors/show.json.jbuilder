json.partial! 'v1/instructors/instructor', instructor: @instructor
json.grades_url instructor_grades_url(@instructor.id)
json.sections @instructor.sections do |section|
  json.partial! 'v1/sections/section', section: section
end