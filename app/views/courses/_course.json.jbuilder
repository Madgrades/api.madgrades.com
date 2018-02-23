json.extract! course, :uuid, :subject_code, :number, :name
json.course_offerings course.course_offerings do |course_offering|
  json.uuid course_offering.uuid
  json.url course_offering_url(course_offering)
end
json.url course_url(course)