json.current_page @courses.current_page
json.total_pages @courses.total_pages
json.next_page_url url_to_next_page(@courses)
json.results do
  json.array! @courses, partial: 'courses/course', as: :course
end