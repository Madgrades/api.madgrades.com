json.message 'hey :)'
json.examples do
  json.subjects_url v1_subjects_url
  json.subjects_search_url v1_subjects_url(query: 'Engineering')
  json.courses_url v1_courses_url
  json.courses_search_url v1_courses_url(query: 'Computer')
  json.instructors_url v1_instructors_url
  json.instructors_search_url v1_instructors_url(query: 'Leckrone')
end