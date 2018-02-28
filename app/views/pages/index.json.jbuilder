json.message 'hey :)'
json.examples do
  json.subjects_url subjects_url
  json.courses_url courses_url
  json.courses_search_url courses_search_url(query: 'Computer')
  json.instructors_url instructors_url
  json.instructors_search_url instructors_search_url(query: 'Leckrone')
end