json.current_page @courses.current_page
json.total_pages @courses.total_pages
json.total_count @courses.total_count
json.next_page_url url_to_next_page(@courses)
json.results do
  json.array! @courses, partial: 'v1/courses/course', as: :course
end