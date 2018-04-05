json.current_page @subjects.current_page
json.total_pages @subjects.total_pages
json.total_count @subjects.total_count
json.next_page_url url_to_next_page(@subjects)
json.results do
  json.array! @subjects, partial: 'v1/subjects/subject', as: :subject
end