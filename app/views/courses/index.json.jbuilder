json.page @courses.current_page
json.results do
  json.array! @courses, partial: 'courses/course', as: :course
end