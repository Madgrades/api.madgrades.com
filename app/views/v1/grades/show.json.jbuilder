json.cumulative do
  json.partial! 'v1/grades/grade_distribution', grade_distribution: @grade_distribution
end
if @course_offerings
  json.course_offerings @course_offerings do |course_offering|
    json.term_code course_offering['term_code']
    json.cumulative do
      json.partial! 'v1/grades/grade_distribution', grade_distribution: course_offering['cumulative']
    end
    json.sections course_offering['sections'] do |grade_distribution|
      json.partial! 'v1/grades/grade_distribution', grade_distribution: grade_distribution
    end
  end
end