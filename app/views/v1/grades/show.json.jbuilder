json.cumulative do
  json.partial! 'v1/grades/grade_distribution', grade_distribution: @grade_distribution
end
if @course_offerings
  json.course_offerings @course_offerings do |course_offering|
    json.term_code course_offering['term_code']
    json.partial! 'v1/grades/grade_distribution', grade_distribution: course_offering['cumulative']
  end
end
if @instructors
  json.instructors @instructors do |instructor|
    json.instructor_id instructor['instructor_id']
    json.cumulative do
      json.partial! 'v1/grades/grade_distribution', grade_distribution: instructor['cumulative']
    end
    json.course_offerings instructor['course_offerings'] do |grade_distribution|
      json.partial! 'v1/grades/grade_distribution', grade_distribution: grade_distribution
    end
  end
end