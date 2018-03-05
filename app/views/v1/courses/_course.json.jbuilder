json.extract! course, :uuid, :number, :names
json.trends do
  if course.trend('all').nil?
    json.all nil
  else
    json.all do
      json.partial! 'v1/course_trends/course_trend', course_trend: course.trend('all')
    end
  end
  if course.trend('recent').nil?
    json.recent nil
  else
    json.recent do
      json.partial! 'v1/course_trends/course_trend', course_trend: course.trend('recent')
    end
  end
end
json.subjects course.subject_codes
json.url course_url(course)