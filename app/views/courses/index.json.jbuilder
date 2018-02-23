json.current_page @courses.current_page
json.total_pages @courses.total_pages
json.next_page courses_url(:page => @courses.current_page + 1)
json.results do
  json.array! @courses, partial: 'courses/course', as: :course
end