json.partial! 'v1/courses/course', course: @course
json.grades_url course_grades_url(@course.id)
json.course_offerings @course.course_offerings do |course_offering|
  json.partial! 'v1/course_offerings/course_offering', course_offering: course_offering
end