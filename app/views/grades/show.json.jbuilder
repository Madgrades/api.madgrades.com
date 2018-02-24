json.cumulative do
  json.partial! 'grades/grade_distribution', grade_distribution: @grade_distribution
end
json.course_offerings @course_offerings do |course_offering|
  json.term_code course_offering['term_code']
  json.course_offering_uuid course_offering['course_offering_uuid']
  json.cumulative do
    json.partial! 'grades/grade_distribution', grade_distribution: course_offering['cumulative']
  end
  json.sections course_offering['sections'] do |grade_distribution|
    json.partial! 'grades/grade_distribution', grade_distribution: grade_distribution
  end
end