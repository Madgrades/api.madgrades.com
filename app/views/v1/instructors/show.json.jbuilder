json.partial! 'v1/instructors/instructor', instructor: @instructor
json.sections @instructor.sections do |section|
  json.partial! 'v1/sections/section', section: section
end