json.course_uuid @course.uuid
json.cumulative do
  json.partial! 'v1/grades/grade_distribution', grade_distribution: @cumulative
end
json.courseOfferings @grade_distributions.each do |grade_dist|
  json.term_code grade_dist.term_code
  json.partial! 'v1/grades/grade_distribution', grade_distribution: GradeDistribution.zero + grade_dist
end
json.instructors @instructors do |instructor|
  json.id instructor[:id]
  json.cumulative do
    json.partial! 'v1/grades/grade_distribution', grade_distribution: instructor[:cumulative]
  end
  json.courseOfferings instructor[:courseOfferings] do |dist|
    json.term_code dist[:term_code]
    json.partial! 'v1/grades/grade_distribution', grade_distribution: GradeDistribution.zero + dist
  end
end
# json.instructors @instructors