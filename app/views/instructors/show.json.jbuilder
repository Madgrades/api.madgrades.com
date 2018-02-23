json.partial! "instructors/instructor", instructor: @instructor
json.sections @instructor.sections do |section|
  json.partial! "sections/section", section: section
end