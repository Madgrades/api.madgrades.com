json.extract! course, :uuid, :subject_code, :number, :name
json.course_offerings course.course_offerings do |course_offering|
  json.partial! "course_offerings/course_offering", course_offering: course_offering
end
json.url course_url(course)