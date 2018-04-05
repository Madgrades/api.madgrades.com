json.current_page @instructors.current_page
json.total_pages @instructors.total_pages
json.total_count @instructors.total_count
json.next_page_url url_to_next_page(@instructors)
json.results do
  json.array! @instructors, partial: 'v1/instructors/instructor', as: :instructor
end