json.extract! course, :uuid, :number
json.name course.name
json.names course.names
json.subjects course.subjects do |subject|
  json.name subject.name
  json.abbreviation subject.abbreviation
  json.code subject.code
end
json.url course_url(course)