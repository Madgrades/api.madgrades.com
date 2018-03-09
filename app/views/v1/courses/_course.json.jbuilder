json.extract! course, :uuid, :number
json.name course.name
json.names course.names
json.changes do
  if course.change('all').nil?
    json.all nil
  else
    json.all do
      json.partial! 'v1/course_changes/course_change', course_change: course.change('all')
    end
  end
  if course.change('recent').nil?
    json.recent nil
  else
    json.recent do
      json.partial! 'v1/course_changes/course_change', course_change: course.change('recent')
    end
  end
end
json.subjects course.subject_codes
json.url course_url(course)