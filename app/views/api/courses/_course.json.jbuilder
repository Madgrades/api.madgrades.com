json.extract! course, :uuid, :number, :names
json.subjects course.subject_codes
json.url course_url(course)