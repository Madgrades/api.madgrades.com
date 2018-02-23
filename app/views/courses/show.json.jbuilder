json.partial! "courses/course", course: @course
json.course_offerings @course.course_offerings do |course_offering|
  json.partial! "course_offerings/course_offering", course_offering: course_offering
end