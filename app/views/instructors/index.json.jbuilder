json.current_page @instructors.current_page
json.total_pages @instructors.total_pages
json.next_page instructors_url(:page => @instructors.current_page + 1)
json.results do
  json.array! @instructors, partial: 'instructors/instructor', as: :instructor
end