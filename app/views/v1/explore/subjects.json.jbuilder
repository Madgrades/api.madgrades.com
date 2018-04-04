json.current_page @grades.current_page
json.total_pages @grades.total_pages
json.next_page_url url_to_next_page(@grades)
json.results @grades.each do |grade|
  json.rank @grades.limit_value * (@grades.current_page - 1) + @grades.index(grade) + 1
  json.subject do
    json.partial! 'v1/subjects/subject', subject: grade.subject
  end
  json.partial! 'v1/explore/default', model: grade
end