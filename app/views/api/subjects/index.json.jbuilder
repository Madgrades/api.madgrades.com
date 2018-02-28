json.current_page @subjects.current_page
json.total_pages @subjects.total_pages
json.next_page_url url_to_next_page(@subjects)
json.results do
  json.array! @subjects, partial: 'api/subjects/subject', as: :subject
end